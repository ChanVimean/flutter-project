import 'package:flutter/material.dart';
import 'package:project/presentation/provider/product_provider.dart';
import 'package:project/presentation/widget/custom_grid_layout.dart';
import 'package:project/presentation/widget/custom_search_service.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: CustomText('Product', textVariant: TextVariant.h2),
        actions: [
          CustomSearchService(products: productProvider.products, isIcon: true),
          const SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: productProvider.refresh,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: CustomGridLayout(products: productProvider.products),
        ),
      ),
    );
  }
}
