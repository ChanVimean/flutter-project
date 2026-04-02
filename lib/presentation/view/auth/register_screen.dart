import 'package:flutter/material.dart';
import 'package:project/core/bottom_navigation.dart';
import 'package:project/presentation/provider/auth_provider.dart';
import 'package:project/presentation/widget/custom_button.dart';
import 'package:project/presentation/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  static TextEditingController username = TextEditingController();
  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();
  static TextEditingController confirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AuthProvider>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create your account",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 16),
            // CustomTextfield(
            //   controller: username,
            //   labelText: 'Username',
            //   hintText: 'username',
            //   filled: true,
            //   prefixIcon: Icon(Icons.person),
            // ),
            CustomTextfield(
              controller: email,
              labelText: 'Email Address',
              hintText: 'username',
              filled: true,
              prefixIcon: Icon(Icons.email_outlined),
            ),
            CustomTextfield(
              controller: password,
              labelText: 'Password',
              hintText: 'password',
              filled: true,
              isPassword: true,
              prefixIcon: Icon(Icons.vpn_key_outlined),
            ),
            // CustomTextfield(
            //   controller: confirmPassword,
            //   labelText: 'Confirm Password',
            //   hintText: 'Confirm Password',
            //   filled: true,
            //   isPassword: true,
            //   prefixIcon: Icon(Icons.vpn_key_outlined),
            // ),
            SizedBox(height: 16),
            CustomButton(
              text: 'Register',
              textColor: Colors.white,
              backgroundColor: Colors.lightGreen,
              action: () async {
                final action = await provider.register(
                  email.text.trim(),
                  password.text,
                );
                if (!context.mounted) return;
                if (action != null) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BottomNavigation(),
                    ),
                    (route) => false,
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Authentication Failed. Please check your details.",
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
            ),
            SizedBox(height: 16),
            Center(
              child: IntrinsicWidth(
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Continue with',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Row(
                    spacing: 8,
                    mainAxisSize: .min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/google.png',
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/facebook.png',
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/apple.png',
                          width: 36,
                          height: 36,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
