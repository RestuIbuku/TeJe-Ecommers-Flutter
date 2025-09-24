class Product {
  final int _id;
  final String _name;
  final double _price;
  final String _description;
  final String _imageUrl;
  final String _category;

  Product({
    required int id,
    required String name, 
    required double price,
    required String description,
    required String imageUrl,
    required String category,
  }) : _id = id,
       _name = name,
       _price = price,
       _description = description,
       _imageUrl = imageUrl,
       _category = category;

  
  int get id => _id;
  String get name => _name;
  double get price => _price;
  String get description => _description;
  String get imageUrl => _imageUrl;
  String get category => _category;


  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'].toDouble(),
      description: json['description'],
      imageUrl: json['imageUrl'],
      category: json['category']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': _id,
      'name': _name,
      'price': _price,
      'description': _description,
      'imageUrl': _imageUrl,
      'category': _category,
    };
  }
}