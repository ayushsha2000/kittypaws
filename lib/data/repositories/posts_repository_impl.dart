import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/entities/reddit_post.dart';
import '../../domain/repositories/posts_repository.dart';
import '../../core/constants/app_constants.dart';

class PostsRepositoryImpl implements PostsRepository {
  final http.Client _client;

  PostsRepositoryImpl(this._client);

  @override
  Future<List<RedditPost>> getPosts(String category) async {
    final subreddits = category == 'cats' 
        ? AppConstants.catSubreddits 
        : AppConstants.dogSubreddits;
    
    final List<RedditPost> allPosts = [];
    
    for (final subreddit in subreddits) {
      try {
        final response = await _client.get(
          Uri.parse('${AppConstants.redditBaseUrl}/r/$subreddit.json?sort=hot&limit=25'),
          headers: {'User-Agent': AppConstants.userAgent},
        );
        
        if (response.statusCode == 200) {
          final jsonData = json.decode(response.body);
          final children = jsonData['data']['children'] as List;
          print('Fetched ${children.length} posts from r/$subreddit');
          
          for (final child in children) {
            try {
              final post = _parseRedditPost(child);
              if (post != null) {
                allPosts.add(post);
              }
            } catch (e) {
              print('Error parsing post: $e');
              // Skip invalid posts
              continue;
            }
          }
        }
      } catch (e) {
        print('Error fetching from r/$subreddit: $e');
        // Continue with other subreddits if one fails
        continue;
      }
    }
    
    // Shuffle posts for variety
    allPosts.shuffle();
    print('Total posts fetched: ${allPosts.length}');
    return allPosts;
  }

  @override
  Future<List<RedditPost>> refreshPosts(String category) async {
    return getPosts(category);
  }

  RedditPost? _parseRedditPost(Map<String, dynamic> json) {
    try {
      final data = json['data'];
      final preview = data['preview'];
      
      // Debug: Print the first post structure
      if (json['data']['id'] == json['data']['id']) { // This will always be true, just to add logging
        print('Parsing post: ${data['title']}');
        print('URL: ${data['url']}');
        print('Is video: ${data['is_video']}');
        print('Domain: ${data['domain']}');
        print('Preview exists: ${preview != null}');
      }
      
      String? imageUrl;
      String? videoUrl;
      
      // Handle video posts
      if (data['is_video'] == true) {
        videoUrl = data['media']?['reddit_video']?['hls_url'];
        if (videoUrl == null) {
          videoUrl = data['url']; // Fallback to direct URL for v.redd.it
        }
      }
      
      // Handle image posts with preview
      if (preview != null && preview['images'] != null && preview['images'].isNotEmpty) {
        final image = preview['images'][0];
        if (image['resolutions'] != null && image['resolutions'].isNotEmpty) {
          // Get the highest resolution image
          final resolutions = image['resolutions'] as List;
          final bestResolution = resolutions.last;
          imageUrl = bestResolution['url'].toString().replaceAll('amp;', '');
        }
      }
      
      // Handle direct image URLs (i.redd.it, imgur, etc.)
      if (imageUrl == null) {
        final url = data['url'].toString();
        if (url.contains('.jpg') || url.contains('.jpeg') || 
            url.contains('.png') || url.contains('.gif') ||
            url.contains('i.redd.it') || url.contains('imgur.com')) {
          imageUrl = url.replaceAll('amp;', '');
        }
      }
      
      // Handle gallery posts
      if (imageUrl == null && data['is_gallery'] == true) {
        final galleryData = data['gallery_data'];
        final mediaMetadata = data['media_metadata'];
        
        if (galleryData != null && mediaMetadata != null) {
          final items = galleryData['items'] as List?;
          if (items != null && items.isNotEmpty) {
            final firstItem = items[0];
            final mediaId = firstItem['media_id'];
            final metadata = mediaMetadata[mediaId];
            
            if (metadata != null) {
              if (metadata['m'] != null) {
                // Image format
                imageUrl = metadata['m'].toString().replaceAll('amp;', '');
              } else if (metadata['s'] != null) {
                // Fallback to source
                imageUrl = metadata['s']['u'].toString().replaceAll('amp;', '');
              }
            }
          }
        }
      }
      
      // Handle Reddit video previews
      if (videoUrl == null && preview?['reddit_video_preview'] != null) {
        videoUrl = preview['reddit_video_preview']['hls_url']?.toString().replaceAll('amp;', '');
      }
      
      // Handle crosspost videos
      if (videoUrl == null && data['crosspost_parent_list'] != null) {
        final crosspost = data['crosspost_parent_list'][0];
        if (crosspost['is_video'] == true) {
          videoUrl = crosspost['media']?['reddit_video']?['hls_url'];
        }
      }

      // Only return posts with media content
      if (imageUrl == null && videoUrl == null) {
        print('No media found for post: ${data['title']}');
        print('Image URL: $imageUrl');
        print('Video URL: $videoUrl');
        return null;
      }

      return RedditPost(
        id: data['id'] ?? '',
        title: data['title'] ?? '',
        url: data['url'] ?? '',
        isVideo: data['is_video'] ?? false,
        videoUrl: videoUrl,
        imageUrl: imageUrl,
        domain: data['domain'] ?? '',
        author: data['author'] ?? '',
        score: _toInt(data['score']),
        numComments: _toInt(data['num_comments']),
        createdAt: DateTime.fromMillisecondsSinceEpoch(
          (_toInt(data['created_utc']) * 1000).toInt(),
        ),
      );
    } catch (e) {
      print('Error parsing post: $e');
      return null;
    }
  }

  /// Helper method to safely convert dynamic values to int
  int _toInt(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value);
      return parsed ?? 0;
    }
    return 0;
  }
}
