import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/widget/custom_text.dart';

class CustomBentoCard extends StatelessWidget {
  final Product product;

  const CustomBentoCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final String imageUrl = (product.thumbnail.isNotEmpty)
        ? product.thumbnail
        : 'assets/images/placeholder-Image.png';
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background
        Image.network(imageUrl, fit: BoxFit.cover),
        // Gradient Overlay for text readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withValues(alpha: 0.5)],
            ),
          ),
        ),
        // Product Details
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                product.name,
                textVariant: TextVariant.h2,
                color: Colors.white,
                maxLines: 2,
              ),
              const SizedBox(height: 4),
              CustomText(
                "\$${product.price}",
                textVariant: TextVariant.h2,
                color: Colors.amber,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
