import 'package:flutter/material.dart';
import 'package:project/presentation/provider/cart_provider.dart';
import 'package:project/presentation/provider/checkout_provider.dart';
import 'package:project/presentation/view/cart/payment_screen.dart';
import 'package:project/presentation/widget/custom_button.dart';
import 'package:project/presentation/widget/custom_section.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:provider/provider.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This makes the widget rebuild whenever notifyListeners() is called
    final checkout = context.watch<CheckoutProvider>();
    final cartProvider = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: CustomText('Checkout', textVariant: TextVariant.h2),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 2));
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          children: [
            // 1. Delivery Address
            const Section(
              title: 'Shipping Address',
              children: [
                ListTile(
                  leading: Icon(Icons.location_on),
                  title: CustomText(
                    '123 Main St, Springfield',
                    textVariant: TextVariant.body,
                  ),
                  subtitle: CustomText(
                    'Home Address',
                    textVariant: TextVariant.muted,
                  ),
                  trailing: Icon(Icons.edit, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // 2. Delivery Method
            Section(
              title: 'Delivery Method',
              children: [
                RadioGroup<int>(
                  // BACK TO groupValue: This is the correct parameter name
                  groupValue: checkout.selectedDelivery,
                  onChanged: (value) => checkout.setDelivery(value!),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => checkout.setDelivery(1),
                        leading: const Icon(Icons.local_shipping_outlined),
                        title: const CustomText('Standard Shipping'),
                        subtitle: const CustomText(
                          '3-5 business days',
                          textVariant: TextVariant.muted,
                        ),
                        // Individual Radios no longer need groupValue or onChanged
                        trailing: const Radio<int>(value: 1),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        onTap: () => checkout.setDelivery(2),
                        leading: const Icon(Icons.flash_on_outlined),
                        title: const CustomText('Express Shipping'),
                        subtitle: const CustomText(
                          '1-2 business days',
                          textVariant: TextVariant.muted,
                        ),
                        trailing: const Radio<int>(value: 2),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // 3. Payment Method
            Section(
              title: 'Payment Method',
              children: [
                RadioGroup<String>(
                  groupValue: checkout.selectedPaymentId,
                  onChanged: (value) => checkout.setPayment(value!),
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () => checkout.setPayment('card_1'),
                        leading: const Icon(Icons.credit_card),
                        title: const CustomText('Visa **** 1234'),
                        subtitle: const CustomText(
                          'Expires 12/26',
                          textVariant: TextVariant.muted,
                        ),
                        trailing: const Radio<String>(value: 'card_1'),
                      ),
                      const Divider(height: 1, indent: 56),
                      // Static Wallet Option
                      ListTile(
                        onTap: () => checkout.setPayment('wallet_1'),
                        leading: const Icon(
                          Icons.account_balance_wallet_outlined,
                        ),
                        title: const CustomText('ABA'),
                        subtitle: const CustomText(
                          'Expires 11/27',
                          textVariant: TextVariant.muted,
                        ),
                        trailing: const Radio<String>(value: 'wallet_1'),
                      ),
                      const Divider(height: 1, indent: 56),
                      ListTile(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const PaymentScreen(),
                          ),
                        ),
                        leading: const Icon(
                          Icons.add_circle_outline,
                          color: Colors.blue,
                        ),
                        title: const CustomText(
                          'Add New Payment Method',
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            // 4. Order Summary
            CustomText('Order Summary', textVariant: TextVariant.h2),
            const SizedBox(height: 16.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(10),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                spacing: 8.0,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _summaryRow('Subtotal', cartProvider.subtotal()),
                  _summaryRow('Discount Vouchers', cartProvider.discount()),
                  _summaryRow('Delivery Subtotal', cartProvider.delivery()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          border: Border(top: BorderSide(color: Colors.grey.withAlpha(20))),
        ),
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText('Total', textVariant: TextVariant.h2),
                CustomText(
                  '\$${cartProvider.total().toStringAsFixed(2)}',
                  textVariant: TextVariant.h2,
                  color: Colors.blue[600],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Action Button
            CustomButton(
              action: () {
                // Logic for Confirm Order
              },
              text: 'Confirm Order',
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(label, textVariant: TextVariant.body),
          CustomText(
            '\$${amount.toStringAsFixed(2)}',
            textVariant: TextVariant.h3,
          ),
        ],
      ),
    );
  }
}
