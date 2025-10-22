import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/cart_service.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final CartService _cartService = CartService();

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/product-detail', arguments: product);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section - Fixed height
                SizedBox(
                  height: constraints.maxWidth * 0.8, // Aspect ratio for image
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(product.imageUrl, fit: BoxFit.cover),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Sale!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Content Section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Product Info
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              product.name,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'Rp ${product.price.toStringAsFixed(0)}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.star,
                                  size: 12,
                                  color: Colors.amber,
                                ),
                                const SizedBox(width: 2),
                                const Text(
                                  '4.5',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Buttons
                        SizedBox(
                          height: 26,
                          child: Row(
                            children: [
                              Expanded(
                                child: MaterialButton(
                                  onPressed: () async {
                                    await _cartService.addToCart(product);
                                    Navigator.pushNamed(context, '/cart');
                                  },
                                  color: Colors.blue,
                                  textColor: Colors.white,
                                  padding: EdgeInsets.zero,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  child: const Text(
                                    'Beli',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 4),
                              SizedBox(
                                width: 26,
                                child: MaterialButton(
                                  onPressed: () async {
                                    await _cartService.addToCart(product);
                                    if (!context.mounted) return;
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Ditambahkan ke keranjang',
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                  },
                                  padding: EdgeInsets.zero,
                                  color: Colors.blue[50],
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    size: 14,
                                    color: Colors.blue[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class ProductList extends StatelessWidget {
  final List<Product> products;

  const ProductList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth < 600
            ? 2
            : constraints.maxWidth < 900
            ? 3
            : 4;

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 0.68,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        );
      },
    );
  }
}
