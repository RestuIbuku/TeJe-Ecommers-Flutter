class CartItem {
  final int _id;
  final int _productId;
  int _quantity;
  final double _price;

  CartItem({
    required int id,
    required int productId,
    required int quantity,
    required double price,
  })  : _id = id,
        _productId = productId,
        _quantity = quantity,
        _price = price;

  int get id => _id;
  int get productId => _productId;
  int get quantity => _quantity;
  double get price => _price;
  double get total => _price * _quantity;

  void incrementQuantity() => _quantity++;
  void decrementQuantity() {
    if (_quantity > 1) _quantity--;
  }
}