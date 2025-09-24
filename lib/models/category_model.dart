class Category {
  final String _id;
  final String _name;
  final String _imageUrl;

  Category({
    required String id,
    required String name,
    required String imageUrl,
  }) : _id = id,
       _name = name,
       _imageUrl = imageUrl;

  
  String get id => _id;
  String get name => _name;
  String get imageUrl => _imageUrl;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'imageUrl': _imageUrl,
    };
  }
}