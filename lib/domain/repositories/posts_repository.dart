import '../entities/reddit_post.dart';

abstract class PostsRepository {
  Future<List<RedditPost>> getPosts(String category);
  Future<List<RedditPost>> refreshPosts(String category);
}
