import 'package:flutter/material.dart';
import 'package:project/presentation/provider/cart_provider.dart';
import 'package:project/presentation/provider/navigation_provider.dart';
import 'package:project/presentation/provider/product_provider.dart';
import 'package:project/presentation/widget/custom_bento_generator.dart';
import 'package:project/presentation/widget/custom_grid_layout.dart';
import 'package:project/presentation/widget/custom_image_slider.dart';
import 'package:project/presentation/widget/custom_search_service.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:project/presentation/widget/custom_text_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final cartProvider = context.watch<CartProvider>();
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://i.pinimg.com/736x/db/38/29/db382916e20ffe546ff6e5ae6a1b0de0.jpg",
            ),
            radius: 24,
            backgroundColor: Colors.transparent,
          ),
          title: CustomText(
            'Welcome back, Worrior!',
            textVariant: TextVariant.h3,
          ),
          subtitle: CustomText(
            'Let\'s find your best product',
            textVariant: TextVariant.muted,
          ),
        ),
        centerTitle: false,
        actionsPadding: EdgeInsets.only(right: 4),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_active_outlined),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: () => context.read<NavigationProvider>().setIndex(2),
                icon: Icon(Icons.shopping_cart_outlined),
              ),
              cartProvider.carts.isEmpty
                  ? SizedBox.shrink()
                  : Positioned(
                      top: 0,
                      right: 5,
                      child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${cartProvider.carts.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              floating:
                  true, // Allows the bottom (search bar) to hide on scroll
              snap: true, // Makes search pop back in quickly when scrolling up
              forceElevated: innerBoxIsScrolled,
              title: CustomSearchService(
                products: productProvider.products,
                isIcon: false,
              ),
            ),
          ];
        },
        body: RefreshIndicator(
          onRefresh: productProvider.refresh,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomImageSlider(
                  items: productProvider.products
                      .take(5)
                      .map((i) => i.thumbnail)
                      .toList(),
                  height: 320,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("Special For You", textVariant: TextVariant.h2),
                    CustomTextButton(
                      action: () {},
                      text: 'See all',
                      fontSize: 14,
                    ),
                  ],
                ),
                CustomBentoGenerator(
                  products: productProvider.products,
                  limit: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText("New Stock", textVariant: TextVariant.h2),
                    CustomTextButton(
                      action: () {},
                      text: 'See all',
                      fontSize: 14,
                    ),
                  ],
                ),
                CustomGridLayout(products: productProvider.products),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
