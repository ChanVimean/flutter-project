import 'package:flutter/material.dart';
import 'package:project/presentation/provider/auth_provider.dart';
import 'package:project/presentation/provider/theme_provider.dart';
import 'package:project/presentation/view/auth/login_screen.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(8),
        child: Column(
          children: [
            Card(
              elevation: 0,
              child: SwitchListTile(
                secondary: Icon(
                  themeProvider.themeMode == ThemeMode.dark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
                title: Text(
                  themeProvider.themeMode == ThemeMode.dark
                      ? "Dark Mode"
                      : "Light Mode",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  themeProvider.themeMode == ThemeMode.dark
                      ? 'Dark theme is active'
                      : 'Light theme is active',
                ),
                value: themeProvider.themeMode == ThemeMode.dark,
                onChanged: (bool value) => themeProvider.toggleTheme(value),
                activeThumbColor: Colors.blueAccent,
                inactiveThumbColor: Colors.blueGrey,
              ),
            ),
            Card(
              child: ListTile(
                onTap: () async {
                  await context.read<AuthProvider>().logout();
                  if (context.mounted) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                      (route) => false,
                    );
                  }
                },
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const CustomText(
                  "Sign Out",
                  textVariant: TextVariant.body,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
