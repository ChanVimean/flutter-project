import 'package:flutter/material.dart';
import 'package:project/data/model/product.dart';
import 'package:project/presentation/provider/cart_provider.dart';
import 'package:project/presentation/widget/custom_image_slider.dart';
import 'package:project/presentation/widget/custom_table_detail.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  List<String> get images => [
    widget.product.thumbnail,
    ...widget.product.images,
  ];

  late int _qty = 1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: CustomText("Product Details", textVariant: TextVariant.h2),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Favorite
            },
            icon: Icon(Icons.favorite_outline, color: Colors.red),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomImageSlider(items: images, height: 350),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(widget.product.name, textVariant: TextVariant.h3),
                  CustomText(
                    "\$${widget.product.price}",
                    textVariant: TextVariant.h1,
                    color: Colors.lightBlueAccent,
                  ),
                  Row(
                    spacing: 8,
                    children: [
                      CustomText("Categories: "),
                      ...widget.product.category.map(
                        (e) => Chip(label: Text(e)),
                      ),
                    ],
                  ),
                  CustomText("Description", textVariant: TextVariant.h3),
                  CustomText(
                    widget.product.description,
                    textVariant: TextVariant.muted,
                  ),
                  Divider(),
                  CustomTableDetail(
                    items: widget.product,
                    whitelistKeys: [
                      "series_title",
                      "origin_type",
                      "characters",
                      "manufacturer",
                      "scale",
                      "material",
                      "release_date",
                      "status",
                      "_id",
                    ],
                  ),
                  Divider(),
                  Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText("Tags: "),
                      Expanded(
                        child: Wrap(
                          spacing: 12,
                          children: (widget.product.tags)
                              .map((tag) => Chip(label: Text(tag)))
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: 40,
        ),
        child: Row(
          spacing: 16,
          children: [
            // Quantity Selector
            Container(
              decoration: BoxDecoration(
                color: colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                spacing: 8,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        if (_qty > 1) _qty--;
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Text(
                    "$_qty",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () => setState(() => _qty++),
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),
            // Add to Cart Button
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed: () {
                  context.read<CartProvider>().addToCart(
                    widget.product,
                    quantity: _qty,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: theme.brightness == Brightness.dark
                          ? Colors.blueAccent
                          : colorScheme.primary,
                      content: CustomText(
                        "Added $_qty item(s) to cart!",
                        textVariant: TextVariant.body,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
