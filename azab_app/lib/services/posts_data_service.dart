import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'post.dart';

class PostsDataService {
  static const String _postsKey = 'azab_posts';
  static const String _likedPostsKey = 'azab_liked_posts';
  static const String _commentedPostsKey = 'azab_commented_posts';
  static const String _sharedPostsKey = 'azab_shared_posts';

  static final PostsDataService _instance = PostsDataService._internal();

  factory PostsDataService() {
    return _instance;
  }

  PostsDataService._internal();

  late SharedPreferences _prefs;
  late List<Post> _posts = [];

  // Initialize the service
  Future<void> initialize(List<Post> defaultPosts) async {
    _prefs = await SharedPreferences.getInstance();
    await _loadPosts(defaultPosts);
  }

  // Load posts from storage or use default posts
  Future<void> _loadPosts(List<Post> defaultPosts) async {
    final String? postsJson = _prefs.getString(_postsKey);

    if (postsJson != null && postsJson.isNotEmpty) {
      try {
        final List<dynamic> decoded = jsonDecode(postsJson);
        _posts = decoded.map((p) => Post.fromJson(p as Map<String, dynamic>)).toList();
      } catch (e) {
        // If there's an error loading, use default posts
        _posts = defaultPosts;
        await _savePosts();
      }
    } else {
      // First time - save default posts
      _posts = defaultPosts;
      await _savePosts();
    }
  }

  // Get all posts
  List<Post> getPosts() {
    return _posts;
  }

  // Save posts to storage
  Future<void> _savePosts() async {
    try {
      final List<Map<String, dynamic>> postsJson = _posts.map((p) => p.toJson()).toList();
      await _prefs.setString(_postsKey, jsonEncode(postsJson));
    } catch (e) {
      print('Error saving posts: $e');
    }
  }

  // Toggle like on a post
  Future<void> toggleLike(int postId) async {
    final postIndex = _posts.indexWhere((p) => p.id == postId);
    if (postIndex != -1) {
      final post = _posts[postIndex];
      post.isLiked = !post.isLiked;
      post.likes += post.isLiked ? 1 : -1;
      _posts[postIndex] = post;
      await _savePosts();
    }
  }

  // Toggle comment on a post
  Future<void> toggleComment(int postId) async {
    final postIndex = _posts.indexWhere((p) => p.id == postId);
    if (postIndex != -1) {
      final post = _posts[postIndex];
      post.isCommented = !post.isCommented;
      post.comments += post.isCommented ? 1 : -1;
      _posts[postIndex] = post;
      await _savePosts();
    }
  }

  // Toggle share on a post
  Future<void> toggleShare(int postId) async {
    final postIndex = _posts.indexWhere((p) => p.id == postId);
    if (postIndex != -1) {
      final post = _posts[postIndex];
      post.isShared = !post.isShared;
      post.shares += post.isShared ? 1 : -1;
      _posts[postIndex] = post;
      await _savePosts();
    }
  }

  // Get post by ID
  Post? getPostById(int postId) {
    try {
      return _posts.firstWhere((p) => p.id == postId);
    } catch (e) {
      return null;
    }
  }

  // Clear all data (for debugging or logout)
  Future<void> clearAllData() async {
    _posts = [];
    await _prefs.remove(_postsKey);
    await _prefs.remove(_likedPostsKey);
    await _prefs.remove(_commentedPostsKey);
    await _prefs.remove(_sharedPostsKey);
  }
}
