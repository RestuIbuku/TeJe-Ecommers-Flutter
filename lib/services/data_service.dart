import '../models/product_model.dart';
import '../models/category_model.dart';

class DataService {
  static final List<Category> categories = [
    Category(
      id: '1',
      name: 'Sepatu',
      imageUrl: 'assets/images/sepatu.png',
    ),
    Category(
      id: '2',
      name: 'Baju',
      imageUrl: 'assets/images/baju.png',
    ),
    Category(
      id: '3',
      name: 'Tas',
      imageUrl: 'assets/images/tas.png',
    ),
    Category(
      id: '4',
      name: 'Celana',
      imageUrl: 'assets/images/celana.png',
    ),
    Category(
      id: '5',
      name: 'Sandal',
      imageUrl: 'assets/images/sandal.png',
    ),
    Category(
      id: '6',
      name: 'Tumblr',
      imageUrl: 'assets/images/tumblr.png',
    ),
  ];

  static final List<Product> products = [
    Product(
      id: 1,
      name: 'Sepatu Super',
      price: 1500000,
      description: 'Sepatu super terbaru dengan teknologi terkini',
      imageUrl: 'assets/images/produk-sepatu.jpeg',
      category: '1',
    ),
    Product(
      id: 2,
      name: 'Jersey king MU',
      price: 250000,
      description: 'Jersey king MU pembawa kemenangan',
      imageUrl: 'assets/images/kaos-jerseyMU.jpg',
      category: '2',
    ),
    Product(
      id: 3,
      name: 'Celana Jeans',
      price: 250000,
      description: 'Celana jeans nyaman untuk aktivitas sehari-hari, terbuat dari bahan denim berkualitas tinggi',
      imageUrl: 'assets/images/celana-jeans.jpg',
      category: '4',
    ),
    Product(
      id: 4,
      name: 'Sendal king MU',
      price: 250000,
      description: 'Sendal king MU nyaman untuk aktivitas sehari-hari, dijamin menang terus pakek ini',
      imageUrl: 'assets/images/sendal-MU.jpg',
      category: '5',
    ),
    Product(
      id: 5,
      name: 'Tas Ibukkk',
      price: 250000,
      description: 'Tas belanja ibuk ini nyaman untuk aktivitas sehari-hari, terbuat dari bahan berkualitas tinggi',
      imageUrl: 'assets/images/tas-belanja.jpg',
      category: '3',
    ),
    Product(
      id: 6,
      name: 'Tas Setan',
      price: 250000,
      description: 'Tas king MU nyaman untuk aktivitas sehari-hari, terbuat dari papan bawah berkualitas tinggi',
      imageUrl: 'assets/images/tas-MU.jpg',
      category: '3',
    ),
    Product(
      id: 7,
      name: 'Tumblr Onana',
      price: 250000,
      description: 'Tumblr king Onanan cocok buat laga finalll',
      imageUrl: 'assets/images/tumblr-MU.jpg',
      category: '6',
    ),
  ];

  static List<Product> getProductsByCategory(String categoryId) {
    return products.where((product) => product.category == categoryId).toList();
  }
}