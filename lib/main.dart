import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'models/product_model.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/product_detail_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/account_screen.dart';

void main() {
  initializeDateFormatting('id');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TeJe E-Commerce',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/account': (context) => const AccountScreen(),
        '/product-detail': (context) => ProductDetailScreen(
              product: ModalRoute.of(context)!.settings.arguments as Product,
            ),
      },
    );
  }
}