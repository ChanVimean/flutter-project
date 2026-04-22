import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project/presentation/provider/auth_provider.dart';
import 'package:project/presentation/provider/theme_provider.dart';
import 'package:project/presentation/view/auth/login_screen.dart';
import 'package:project/presentation/widget/custom_text.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final List<GroupTileModel> generalInfo = [
    GroupTileModel(
      icon: const Icon(Icons.person),
      title: 'Personal Information',
      onTap: () {
        log('index 0');
      },
    ),
    GroupTileModel(
      icon: const Icon(Icons.lock),
      title: 'Lock App',
      onTap: () {
        log('index 1');
      },
    ),
    GroupTileModel(
      icon: const Icon(Icons.verified_user),
      title: 'Privacy Settings',
      onTap: () {
        log('index 2');
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    return Scaffold(
      appBar: AppBar(title: Text('Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(
          spacing: 16,
          children: [
            // Profile
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(18),
                color: Theme.of(context).cardColor,
              ),
              child: ListTile(
                onTap: () {
                  // TODO: Profile Screen
                },
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(
                    'https://static0.polygonimages.com/wordpress/wp-content/uploads/chorus/uploads/chorus_asset/file/9490719/thor_big.jpg?w=1600&h=900&fit=crop',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
                title: CustomText('Stephen', textVariant: TextVariant.h3),
                subtitle: CustomText(
                  'stephen@gmail.com',
                  textVariant: TextVariant.muted,
                ),
              ),
            ),
            // General Information
            _buildGroupContainer(context, 'General Information', generalInfo),
            // Theme Switch
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
            // Logout
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

  Widget _buildGroupContainer(
    BuildContext context,
    String label,
    List<GroupTileModel> groupTileData,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(label, textVariant: TextVariant.h3),
          SizedBox(height: 8),
          ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: groupTileData.length,
            itemBuilder: (context, index) {
              final item = groupTileData[index];
              return ListTile(
                onTap: () => item.onTap(),
                leading: item.icon,
                title: CustomText(item.title, textVariant: TextVariant.body),
              );
            },
          ),
        ],
      ),
    );
  }
}

class GroupTileModel {
  Icon icon;
  String title;
  VoidCallback onTap;

  GroupTileModel({
    required this.icon,
    required this.title,
    required this.onTap,
  });
}
