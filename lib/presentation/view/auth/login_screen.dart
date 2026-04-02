import 'package:flutter/material.dart';
import 'package:project/core/bottom_navigation.dart';
import 'package:project/presentation/provider/auth_provider.dart';
import 'package:project/presentation/view/auth/register_screen.dart';
import 'package:project/presentation/widget/custom_button.dart';
import 'package:project/presentation/widget/custom_text_button.dart';
import 'package:project/presentation/widget/custom_textfield.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static TextEditingController email = TextEditingController();
  static TextEditingController password = TextEditingController();

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
              "Hey,\nLogin Now.",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text("If you are new?"),
                CustomTextButton(
                  action: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  ),
                  text: 'Create account',
                ),
              ],
            ),
            SizedBox(height: 16),
            CustomTextfield(
              controller: email,
              labelText: 'Email Address',
              hintText: 'example@gmail.com',
              filled: true,
              prefixIcon: Icon(Icons.email_outlined),
            ),
            CustomTextfield(
              controller: password,
              labelText: 'Password',
              hintText: 'password',
              filled: true,
              prefixIcon: Icon(Icons.vpn_key_outlined),
            ),
            Row(
              children: [
                Text("Forgot Password?"),
                CustomTextButton(action: () {}, text: 'Reset password'),
              ],
            ),
            SizedBox(height: 16),
            CustomButton(
              text: 'Login',
              textColor: Colors.white,
              action: () async {
                final action = await provider.login(email.text, password.text);
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
                        "Login Failed. Please provide valid email.",
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  );
                }
              },
            ),
            CustomButton(
              action: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => BottomNavigation()),
                (route) => false,
              ),
              text: 'Skip',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              backgroundColor: Colors.transparent,
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
