import 'package:flutter/material.dart';
import 'package:products/providers/cart_provider.dart';
import 'package:products/providers/products_provider.dart';
import 'package:products/screens/cart_screen.dart';
import 'package:products/screens/home_screen.dart';
import 'package:products/screens/product_details_screen.dart';
import 'package:products/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProductsProvider()),
        ChangeNotifierProvider(create: (ctx) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: SpalshScreen.routeName,
        home: HomeScreen(),
        routes: {
          SpalshScreen.routeName: (ctx) => const SpalshScreen(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
        },
      ),
    );
  }
}
