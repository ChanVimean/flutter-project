import 'package:flutter/material.dart';
import 'package:project/core/bottom_navigation.dart';
import 'package:project/presentation/provider/product_provider.dart';
import 'package:project/presentation/widget/custom_loading.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _startApp();
    Future.microtask(() async {
      if (!mounted) return;
      final provider = context.read<ProductProvider>();
      await provider.fetchProduct();
      if (provider.isError == null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavigation()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ProductProvider>();
    return Scaffold(
      body: Center(
        child: provider.isError != null
            ? Text(
                "Error: ${provider.isError}",
                style: TextStyle(color: Colors.redAccent),
              )
            : const CustomLoading(),
      ),
    );
  }
}
