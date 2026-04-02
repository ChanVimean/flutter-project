import 'package:flutter/material.dart';
import 'package:project/presentation/provider/cart_provider.dart';
import 'package:project/presentation/provider/product_provider.dart';
import 'package:project/presentation/provider/theme_provider.dart';
import 'package:project/presentation/view/detail/detail_screen.dart';
import 'package:project/presentation/widget/custom_button.dart';
import 'package:project/presentation/widget/custom_search_service.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final cartProvider = context.watch<CartProvider>();
    final productProvder = context.watch<ProductProvider>();
    return Scaffold(
      appBar: AppBar(
        title: CustomText('Cart', textVariant: TextVariant.h2),
        actions: [
          CustomSearchService(products: productProvder.products, isIcon: true),
          const SizedBox(width: 10),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => cartProvider.refreshCart(),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemCount: cartProvider.carts.length,
          itemBuilder: (context, index) {
            final item = cartProvider.carts[index];
            final price = item.qty != 0 ? item.price * item.qty! : item.price;
            return Dismissible(
              key: Key(item.uuid),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  // Match your card's radius
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.delete, color: Colors.white, size: 30),
              ),
              onDismissed: (direction) {
                cartProvider.removeFromCart(item.uuid);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${item.name} removed from cart"),
                    action: SnackBarAction(
                      label: "UNDO",
                      onPressed: () => cartProvider.addToCart(item),
                    ),
                  ),
                );
              },
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(product: item),
                  ),
                ),
                borderRadius: BorderRadius.circular(
                  20,
                ), // Match the card's radius
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: themeProvider.themeMode == ThemeMode.dark
                        ? Theme.of(context).focusColor
                        : Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ), // Match the Dismissible background radius
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(5),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // 1. IMAGE SECTION
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          item.thumbnail,
                          width: 110,
                          height: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // 2. MIDDLE INFO (Expanded pushes the next column to the right)
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              item.name,
                              textVariant: TextVariant.h3,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 4),
                            CustomText(
                              "Status: ${item.status} | ${item.category.join(", ")}",
                              textVariant: TextVariant.small,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color?.withAlpha(200),
                              maxLines: 1,
                            ),
                            const SizedBox(height: 8),
                            // Qty Controls
                            Row(
                              children: [
                                CustomText(
                                  "\$${price.toStringAsFixed(2)}",
                                  textVariant: TextVariant.h2,
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () =>
                                      cartProvider.decrementQty(item.uuid),
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.redAccent,
                                    size: 28,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                  ),
                                  child: CustomText(
                                    "${item.qty}",
                                    textVariant: TextVariant.body,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      cartProvider.incrementQty(item.uuid),
                                  icon: Icon(
                                    Icons.add_circle,
                                    color:
                                        themeProvider.themeMode ==
                                            ThemeMode.dark
                                        ? Colors.lightBlueAccent
                                        : Colors.blueGrey,
                                    size: 28,
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
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 190,
        margin: const EdgeInsets.all(12.0),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: themeProvider.themeMode == ThemeMode.dark
              ? Theme.of(context).hoverColor
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Subtotal', textVariant: TextVariant.body),
                CustomText('\$0.00', textVariant: TextVariant.h3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Discount Vouchers', textVariant: TextVariant.body),
                CustomText('\$0.00', textVariant: TextVariant.h3),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Delivery Subtotal', textVariant: TextVariant.body),
                CustomText('\$0.00', textVariant: TextVariant.h3),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Total', textVariant: TextVariant.h2),
                CustomText(
                  '\$0.00',
                  textVariant: TextVariant.h2,
                  color: Colors.blue[600],
                ),
              ],
            ),
            const SizedBox(height: 8),
            CustomButton(action: () {}, text: 'Checkout'),
          ],
        ),
      ),
    );
  }
}
