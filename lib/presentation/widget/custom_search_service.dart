import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/view/detail/detail_screen.dart';
import 'package:project/presentation/widget/custom_search_delegate.dart';
import 'package:project/presentation/widget/custom_textfield.dart';

class CustomSearchService extends StatelessWidget {
  final List<Product> products;
  final bool isIcon;

  const CustomSearchService({
    super.key,
    required this.products,
    this.isIcon = true,
  });

  Future<void> _triggerSearch(BuildContext context) async {
    final Product? selected = await showSearch<Product?>(
      context: context,
      delegate: CustomSearchDelegate(allProducts: products),
    );

    if (context.mounted && selected != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailScreen(product: selected)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isIcon) {
      return Builder(
        builder: (context) => IconButton(
          icon: const Icon(Icons.search),
          onPressed: () => _triggerSearch(context),
        ),
      );
    }

    return GestureDetector(
      onTap: () => _triggerSearch(context),
      child: CustomTextfield(
        controller: null,
        prefixIcon: Icon(Icons.search),
        hintText: "Search for figures...",
        readOnly: true,
        onTap: () => _triggerSearch(context),
      ),
    );
  }
}
