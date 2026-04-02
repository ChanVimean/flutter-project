import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/provider/product_provider.dart';
import 'package:project/presentation/widget/custom_grid_layout.dart';
import 'package:project/presentation/widget/custom_search_service.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product> _randomizedProducts = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateRandomDiscovery();
    });
  }

  void _generateRandomDiscovery() {
    final allProducts = context.read<ProductProvider>().products;
    setState(() {
      _randomizedProducts = [...allProducts]..shuffle();
    });
  }

  Future<void> _onRefresh() async {
    // Give the user that satisfying "loading" haptic feel
    await Future.delayed(const Duration(milliseconds: 800));
    _generateRandomDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final randomProducts = [...productProvider.products]..shuffle();
    return Scaffold(
      appBar: AppBar(
        title: CustomSearchService(products: randomProducts, isIcon: false),
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        color: Theme.of(context).colorScheme.primary,
        child: SingleChildScrollView(
          // Logic: Always allow scroll so refresh works even with 1-2 items
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text(
                  "Discover Figures",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              // The Grid showing your randomized "Discovery" set
              CustomGridLayout(products: _randomizedProducts),
            ],
          ),
        ),
      ),
    );
  }
}
