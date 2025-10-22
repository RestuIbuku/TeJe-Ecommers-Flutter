import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../models/product_model.dart';
import '../services/data_service.dart';
import '../widgets/product_card.dart';
import '../widgets/category_list.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/gradient_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  String selectedCategoryId = '';
  List<Product> displayedProducts = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    displayedProducts = DataService.products;
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('current_user');

    if (userString != null) {
      final userData = User.fromJson(jsonDecode(userString));
      if (!mounted) return;
      setState(() {
        userName = userData.name;
      });
    }
  }

  void _selectCategory(String categoryId) {
    setState(() {
      selectedCategoryId = categoryId;
      displayedProducts = categoryId.isEmpty
          ? DataService.products
          : DataService.getProductsByCategory(categoryId);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.pushNamed(context, '/account');
        break;
      case 2:
        Navigator.pushNamed(context, '/cart');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(userName: userName),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 35, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Beranda'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Keranjang'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/cart');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Akun'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/account');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Keluar'),
              onTap: () => Navigator.pushReplacementNamed(context, '/login'),
            ),
          ],
        ),
      ),
      body: GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                children: [
                  Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    child: CategoryList(
                      selectedCategoryId: selectedCategoryId,
                      onCategorySelected: _selectCategory,
                    ),
                  ),

                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.75,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                          ),
                      itemCount: displayedProducts.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: displayedProducts[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
        ],
        onTap: _onItemTapped,
      ),
    );
  }
}
