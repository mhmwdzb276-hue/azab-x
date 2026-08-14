// Post Data Model with persistent data support
class Post {
  final int id;
  final String author;
  final String avatar;
  final String timestamp;
  final String content;
  final String? image;
  int likes;
  int comments;
  int shares;
  bool isLiked;
  bool isCommented;
  bool isShared;

  Post({
    required this.id,
    required this.author,
    required this.avatar,
    required this.timestamp,
    required this.content,
    this.image,
    required this.likes,
    required this.comments,
    required this.shares,
    this.isLiked = false,
    this.isCommented = false,
    this.isShared = false,
  });

  // Convert Post to JSON for storage
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'avatar': avatar,
      'timestamp': timestamp,
      'content': content,
      'image': image,
      'likes': likes,
      'comments': comments,
      'shares': shares,
      'isLiked': isLiked,
      'isCommented': isCommented,
      'isShared': isShared,
    };
  }

  // Create Post from JSON
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      author: json['author'] as String,
      avatar: json['avatar'] as String,
      timestamp: json['timestamp'] as String,
      content: json['content'] as String,
      image: json['image'] as String?,
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
      shares: json['shares'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isCommented: json['isCommented'] as bool? ?? false,
      isShared: json['isShared'] as bool? ?? false,
    );
  }

  // Create a copy of Post with new values
  Post copyWith({
    int? id,
    String? author,
    String? avatar,
    String? timestamp,
    String? content,
    String? image,
    int? likes,
    int? comments,
    int? shares,
    bool? isLiked,
    bool? isCommented,
    bool? isShared,
  }) {
    return Post(
      id: id ?? this.id,
      author: author ?? this.author,
      avatar: avatar ?? this.avatar,
      timestamp: timestamp ?? this.timestamp,
      content: content ?? this.content,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isLiked: isLiked ?? this.isLiked,
      isCommented: isCommented ?? this.isCommented,
      isShared: isShared ?? this.isShared,
    );
  }
}
