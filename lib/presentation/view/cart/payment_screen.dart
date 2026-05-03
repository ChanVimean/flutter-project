import 'package:flutter/material.dart';
import 'package:project/presentation/widget/custom_button.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:project/presentation/widget/custom_textfield.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  static TextEditingController contactInfo = TextEditingController();
  static TextEditingController cardNumber = TextEditingController();
  static TextEditingController expiration = TextEditingController();
  static TextEditingController cvv = TextEditingController();
  static TextEditingController country = TextEditingController();
  static TextEditingController postalCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText('Payment', textVariant: TextVariant.h2),
        actions: [
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1));
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 24.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfield(
                controller: contactInfo,
                labelText: 'Contact Information',
                hintText: 'example@gmail.com',
              ),
              // Card Method Section
              Text('Card method'),
              CustomTextfield(
                controller: cardNumber,
                labelText: 'Card Number',
                hintText: '1234 5678 9012 3456',
              ),
              Row(
                spacing: 24.0,
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: expiration,
                      labelText: 'Expiration',
                      hintText: 'MM/YY',
                    ),
                  ),
                  Expanded(
                    child: CustomTextfield(
                      controller: cvv,
                      labelText: 'CVV',
                      hintText: '123',
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 24.0,
                children: [
                  Expanded(
                    child: CustomTextfield(
                      controller: country,
                      labelText: 'Country',
                      hintText: 'USA',
                    ),
                  ),
                  Expanded(
                    child: CustomTextfield(
                      controller: postalCode,
                      labelText: 'Postal Code',
                      hintText: '12345',
                    ),
                  ),
                ],
              ),
              CustomText(
                'By providing your card information, you allow ACME to your card for future payments in accordance with their terms.',
                textVariant: TextVariant.muted,
                maxLines: 2,
              ),
              const SizedBox(height: 16.0),
              CustomButton(
                action: () {},
                text: 'Add Payment Method',
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
