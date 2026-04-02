import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/view/detail/detail_screen.dart';
import 'package:project/presentation/widget/custom_bento3_layout.dart';

class CustomBentoGenerator extends StatelessWidget {
  final List<Product> products;
  final int? limit;

  const CustomBentoGenerator({super.key, required this.products, this.limit});

  @override
  Widget build(BuildContext context) {
    final int count = limit != null
        ? limit!.clamp(3, products.length)
        : products.length;

    final int groupOfThree = (count / 3).floor();

    if (groupOfThree == 0) return const SizedBox.shrink();

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: groupOfThree,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final bool isReversed = index % 2 != 0;

        return SizedBox(
          child: CustomBento3Layout(
            spacing: 12,
            borderRadius: 24,
            reverse: isReversed,
            topLeft: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(product: products[index]),
                ),
              ),
              borderRadius: BorderRadius.circular(24),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DetailScreen(product: products[index]),
                  ),
                ),
                borderRadius: BorderRadius.circular(24),
                child: _buildImage(products[index].thumbnail),
              ),
            ),
            bottomLeft: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(product: products[index + 1]),
                ),
              ),
              borderRadius: BorderRadius.circular(24),
              child: _buildImage(products[index + 1].thumbnail),
            ),
            rightLarge: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      DetailScreen(product: products[index + 2]),
                ),
              ),
              borderRadius: BorderRadius.circular(24),
              child: _buildImage(products[index + 2].thumbnail),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImage(String image) {
    Widget img = (image.isNotEmpty)
        ? Image.network(image, fit: BoxFit.cover)
        : Image.asset('assets/images/placeholder-Image.png', fit: BoxFit.cover);

    return img;
  }
}
