import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project/core/app_theme.dart';
import 'package:project/data/service/cart_repository.dart';
import 'package:project/presentation/provider/auth_provider.dart';
import 'package:project/presentation/provider/cart_provider.dart';
import 'package:project/presentation/provider/checkout_provider.dart';
import 'package:project/presentation/provider/navigation_provider.dart';
import 'package:project/presentation/provider/product_provider.dart';
import 'package:project/presentation/provider/theme_provider.dart';
import 'package:project/core/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:sembast/sembast_io.dart';

void main() async {
  try {
    // Firebase
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // Init Theme
    final themeProvider = ThemeProvider();
    await themeProvider.init();

    // Open Local Storage DB
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'cart.db');
    final database = await databaseFactoryIo.openDatabase(dbPath);

    // Init Cart Repository
    CartRepository.init(database);

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: themeProvider),
          ChangeNotifierProvider(create: (_) => NavigationProvider()),
          ChangeNotifierProvider(create: (_) => AuthProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()..loadCart()),
          ChangeNotifierProvider(create: (_) => CheckoutProvider()),
        ],
        child: const MyApp(),
      ),
    );
  } catch (e, stack) {
    debugPrint("Initialization Error: $e");
    debugPrint(stack.toString());
    // Fallback to minimal app if DB fails
    runApp(
      MaterialApp(
        home: Scaffold(body: Center(child: Text("Error starting app: $e"))),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;
    return MaterialApp(
      title: 'Project',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeMode,
      home: const SplashScreen(),
    );
  }
}
