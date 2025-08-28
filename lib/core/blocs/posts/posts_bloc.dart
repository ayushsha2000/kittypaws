import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/reddit_post.dart';
import '../../../domain/repositories/posts_repository.dart';

// Events
abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class LoadPosts extends PostsEvent {
  final String category; // 'cats' or 'dogs'

  const LoadPosts(this.category);

  @override
  List<Object?> get props => [category];
}

class RefreshPosts extends PostsEvent {
  final String category;

  const RefreshPosts(this.category);

  @override
  List<Object?> get props => [category];
}

// States
abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsLoaded extends PostsState {
  final List<RedditPost> posts;
  final String category;

  const PostsLoaded(this.posts, this.category);

  @override
  List<Object?> get props => [posts, category];
}

class PostsError extends PostsState {
  final String message;

  const PostsError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _repository;

  PostsBloc(this._repository) : super(PostsInitial()) {
    on<LoadPosts>(_onLoadPosts);
    on<RefreshPosts>(_onRefreshPosts);
  }

  Future<void> _onLoadPosts(LoadPosts event, Emitter<PostsState> emit) async {
    print('Loading posts for category: ${event.category}');
    emit(PostsLoading());
    try {
      final posts = await _repository.getPosts(event.category);
      print('Posts loaded successfully: ${posts.length}');
      emit(PostsLoaded(posts, event.category));
    } catch (e) {
      print('Error loading posts: $e');
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onRefreshPosts(RefreshPosts event, Emitter<PostsState> emit) async {
    try {
      final posts = await _repository.getPosts(event.category);
      emit(PostsLoaded(posts, event.category));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }
}
