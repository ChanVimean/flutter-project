import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/widget/custom_product_card.dart';

class CustomGridLayout extends StatelessWidget {
  final List<Product> products;
  const CustomGridLayout({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.72,
      ),
      itemBuilder: (context, index) {
        return CustomProductCard(product: products[index]);
      },
    );
  }
}
