class Wallpaper {
  final String id;
  final String name;       // photographer or user name
  final String imageUrl;   // direct image URL
  final String category;   // tag or category, default to 'all'

  Wallpaper({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
  });


  /// For Pixabay API
  factory Wallpaper.fromPixabay(Map<String, dynamic> json) {
    return Wallpaper(
      id: json['id'].toString(),
      name: json['user'] ?? 'Unknown',
      imageUrl: json['largeImageURL'] ?? '',
      category: (json['tags'] ?? '').toString().split(',').first.trim(),
    );
  }

  /// Optional: Generic fromJson (only useful for Pexels if saving locally)
  factory Wallpaper.fromJson(Map<String, dynamic> json) {
    final src = json['src'];
    return Wallpaper(
      id: json['id'].toString(),
      name: json['photographer'] ?? 'Unknown',
      imageUrl: src != null ? src['portrait'] ?? '' : '',
      category: 'all',
    );
  }

  /// For local storage or sharing
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'photographer': name,
      'src': {
        'portrait': imageUrl,
      },
      'category': category,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is Wallpaper && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
