import 'package:flutter/material.dart';
import '../services/data_service.dart';

class CategoryList extends StatelessWidget {
  final Function(String) onCategorySelected;
  final String selectedCategoryId;

  const CategoryList({
    super.key,
    required this.onCategorySelected,
    required this.selectedCategoryId,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100, 
      child: ListView.builder(
        itemCount: DataService.categories.length,
        itemBuilder: (context, index) {
          final category = DataService.categories[index];
          return InkWell(
            onTap: () => onCategorySelected(category.id),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: selectedCategoryId == category.id
                    ? Colors.blue.withOpacity(0.1)
                    : null,
                border: Border(
                  right: BorderSide(
                    color: selectedCategoryId == category.id
                        ? Colors.blue
                        : Colors.transparent,
                    width: 3,
                  ),
                ),
              ),
              child: Column(
                children: [
                  Image.asset(category.imageUrl, width: 40, height: 40),
                  const SizedBox(height: 4),
                  Text(
                    category.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selectedCategoryId == category.id
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: selectedCategoryId == category.id
                          ? Colors.blue
                          : Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
