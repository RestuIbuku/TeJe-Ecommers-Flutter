import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback? onMenu;

  const CustomAppBar({Key? key, required this.userName, this.onMenu})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFAppBar(
      elevation: 0,
      backgroundColor: Colors.blue,
      leading: GFIconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        type: GFButtonType.transparent,
        onPressed: onMenu ?? () => Scaffold.of(context).openDrawer(),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TeJe E-Commerce',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            'Selamat Datang, $userName!',
            style: const TextStyle(fontSize: 13),
          ),
        ],
      ),
      actions: [
        GFIconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          type: GFButtonType.transparent,
          onPressed: () {},
        ),
        GFIconBadge(
          counterChild: GFBadge(
            child: const Text(
              '0',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            shape: GFBadgeShape.circle,
            color: Colors.red,
          ),
          child: GFIconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.white),
            type: GFButtonType.transparent,
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
