import 'package:equatable/equatable.dart';

class RedditPost extends Equatable {
  final String id;
  final String title;
  final String url;
  final bool isVideo;
  final String? videoUrl;
  final String? imageUrl;
  final String domain;
  final String author;
  final int score;
  final int numComments;
  final DateTime createdAt;

  const RedditPost({
    required this.id,
    required this.title,
    required this.url,
    required this.isVideo,
    this.videoUrl,
    this.imageUrl,
    required this.domain,
    required this.author,
    required this.score,
    required this.numComments,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        url,
        isVideo,
        videoUrl,
        imageUrl,
        domain,
        author,
        score,
        numComments,
        createdAt,
      ];
}
