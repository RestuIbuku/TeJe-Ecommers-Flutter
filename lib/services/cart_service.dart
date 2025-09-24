import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartService {
  static const String _cartKey = 'cart_items';
  List<CartItem> _items = [];

  Future<List<CartItem>> getItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartString = prefs.getString(_cartKey);
    if (cartString != null) {
      final List<dynamic> cartJson = jsonDecode(cartString);
      _items = cartJson
          .map(
            (item) => CartItem(
              id: item['id'],
              productId: item['productId'],
              quantity: item['quantity'],
              price: item['price'].toDouble(),
            ),
          )
          .toList();
    }
    return _items;
  }

  Future<void> addToCart(Product product) async {
    final prefs = await SharedPreferences.getInstance();
    await getItems();

    final existingItem = _items.firstWhere(
      (item) => item.productId == product.id,
      orElse: () => CartItem(
        id: _items.length + 1,
        productId: product.id,
        quantity: 0,
        price: product.price,
      ),
    );

    if (existingItem.quantity == 0) {
      _items.add(existingItem);
    }
    existingItem.incrementQuantity();

    await prefs.setString(
      _cartKey,
      jsonEncode(
        _items
            .map(
              (item) => {
                'id': item.id,
                'productId': item.productId,
                'quantity': item.quantity,
                'price': item.price,
              },
            )
            .toList(),
      ),
    );
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
    _items.clear();
  }
}
