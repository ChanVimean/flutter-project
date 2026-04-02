import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'dart:math';

enum SearchUIStyle { icon, textField }

class CustomSearchDelegate extends SearchDelegate<Product?> {
  final List<Product> allProducts;
  SearchUIStyle uiStyle;

  CustomSearchDelegate({
    required this.allProducts,
    this.uiStyle = SearchUIStyle.icon,
  });

  final List<String> _hints = [
    "Hunting for your next Holy Grail? 🏆",
    "Find your favorite hero (or villain)!",
    "Looking for a rival for your current display?",
    "Unleash the ultimate search for your favorite characters!",
    "Type a character name to see every version we have...",
    "Don't worry, we won't tell your wallet",
    "Searching for a waifu? No judgment here",
  ];

  // --- Theme Overrides ---

  @override
  String? get searchFieldLabel => _hints[Random().nextInt(_hints.length)];

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: theme.appBarTheme.copyWith(
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(fontSize: 16),
      ),
    );
  }

  // --- Search Delegate Methods ---

  @override
  List<Widget>? buildActions(BuildContext context) => [
    if (query.isNotEmpty)
      IconButton(
        icon: const Icon(Icons.clear, color: Colors.redAccent),
        onPressed: () => query = '',
      ),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back_ios),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildList(context);

  @override
  Widget buildSuggestions(BuildContext context) => _buildList(context);

  // --- The Engine Logic ---

  Widget _buildList(BuildContext context) {
    if (query.isEmpty) {
      return _buildEmptyState();
    }

    final cleanQuery = query.toLowerCase().trim();

    final List<Product> results = allProducts.where((product) {
      bool matchName = product.name.toLowerCase().contains(cleanQuery);
      bool matchSeries = product.seriesTitle.toLowerCase().contains(cleanQuery);

      bool matchCategory = product.category.any(
        (c) => c.toLowerCase().contains(cleanQuery),
      );
      bool matchCharacters = product.characters.any(
        (c) => c.toLowerCase().contains(cleanQuery),
      );
      bool matchOrigin = product.originType.any(
        (o) => o.toLowerCase().contains(cleanQuery),
      );

      return matchName ||
          matchSeries ||
          matchCategory ||
          matchCharacters ||
          matchOrigin;
    }).toList();

    if (results.isEmpty) {
      return Center(
        child: CustomText(
          "No figures found for '$query'",
          textVariant: TextVariant.muted,
        ),
      );
    }

    return ListView.separated(
      separatorBuilder: (_, _) => const Divider(height: 1, indent: 80),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        return _buildProdctTile(context, item);
      },
    );
  }

  // --- Sub Widgets ---

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.search_rounded, size: 80, color: Colors.grey),
          const SizedBox(height: 20),
          CustomText(
            "Are you looking for something?",
            textVariant: TextVariant.h2,
          ),
          const SizedBox(height: 8),
          CustomText(
            "try searching by name, series, characters, ...",
            textVariant: TextVariant.body,
          ),
          if (uiStyle == SearchUIStyle.textField)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: CustomText(
                "Trending: Miku, Dragon Ball, One Piece",
                textVariant: TextVariant.muted,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildProdctTile(BuildContext context, Product item) {
    return ListTile(
      onTap: () => close(context, item),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: item.thumbnail.isNotEmpty
            ? Image.network(
                item.thumbnail,
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => const Icon(Icons.image),
              )
            : Image.asset(
                'assets/images/placeholder-Image.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
      ),
      title: CustomText(item.name, textVariant: TextVariant.h3, maxLines: 1),
      subtitle: Row(
        spacing: 4,
        mainAxisSize: .min,
        children: [
          CustomText(
            "${item.price.toStringAsFixed(2)} ${item.currency}",
            textVariant: TextVariant.h3,
            color: Theme.of(context).colorScheme.primary,
            maxLines: 1,
          ),
          Text(
            "|",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue[800],
            ),
          ),
          Expanded(
            child: CustomText(
              "${item.seriesTitle} • ${item.manufacturer}",
              textVariant: TextVariant.muted,
              maxLines: 1,
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16),
    );
  }
}
