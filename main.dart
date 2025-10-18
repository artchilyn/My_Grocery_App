//Kini nga code mao ang main app launcher sa “My Grocery App” — diri magsugod tanan!
//Gamit siya ug ChangeNotifierProvider aron i-manage ang CartModel globally (para makita ug ma-update ang cart bisan asa nga screen).
//Ang MyApp kay nag-set up sa routes para sa tanan pages (Shop, Cart, Newsstand, Info, Profile), ug si MyHomePage mao ang home screen nga naay app bar, drawer, ug welcome layout.
//Naay cart icon nga mo-update in real-time kung naa kay gi-add nga item, plus button nga mo-navigate diretso sa shop.
//Overall — mao ni ang “brain” ug main flow sa app.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_drawer.dart';
import 'shop.dart';
import 'newsstand.dart';
import 'info.dart';
import 'profile.dart';
import 'cart.dart';

import 'cart_model.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Grocery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: 'My Grocery App'),
        '/shop': (context) => const Shop(),
        '/cart': (context) => const Cart(),
        '/newsstand': (context) => const Newsstand(),
        '/info': (context) => const Info(),
        '/profile': (context) => const Profile(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // 🛒 Cart icon with item counter
          Consumer<CartModel>(
            builder: (context, cart, child) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart_outlined),
                    onPressed: () {
                      Navigator.pushNamed(context, '/cart');
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          cart.items.length.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🛍️ App Icon
              Image.network(
                'https://cdn-icons-png.flaticon.com/512/3081/3081559.png',
                height: 200,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.store, size: 100, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                'Welcome to My Grocery App! 🛒',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Shop your favorite groceries easily and stay updated on great deals and healthy living tips.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                icon: const Icon(Icons.storefront),
                label: const Text('Go to Shop'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () => Navigator.pushNamed(context, '/shop'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
