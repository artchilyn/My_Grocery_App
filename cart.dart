//Kini nga code mao ang cart page sa app; gamit niya si CartModel gikan sa Provider aron ma-access ang mga item sa cart, ug gamit ang Scaffold para ma-display ang layout nga naay AppBar, drawer, ug list sa mga items. Kung empty ang cart, mo-display lang siya ug “Your cart is empty 🛒”; pero kung naay sulod, ipakita niya ang mga items with name, price, quantity, ug image, plus naa’y delete button para tangtangon. Sa ubos, naa’y total price bar ug Checkout button — kung empty ang cart mo-warning siya, pero kung naay sulod, mo-show ug success message then i-clear tanan items. In short, siya ang page nga nag-manage sa imong shopping cart in real-time.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'app_drawer.dart';

class Cart extends StatelessWidget {
  const Cart({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const AppDrawer(),

      // 🧺 Body
      body: cart.items.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty 🛒',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            )
          : ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) {
                final item = cart.items[index];
                final totalItemPrice =
                    (item['price'] * item['quantity']).toStringAsFixed(2);

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 3,
                  child: ListTile(
                    leading: Image.network(
                      item['image'],
                      width: 50,
                      height: 50,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.image_not_supported),
                    ),
                    title: Text(
                      item['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        '₱${item['price']} × ${item['quantity']} = ₱$totalItemPrice'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => cart.removeItem(index),
                    ),
                  ),
                );
              },
            ),

      // 💰 Bottom Summary Bar
      bottomNavigationBar: Container(
        color: Colors.deepPurple.shade50,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: ₱${cart.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
              onPressed: () {
                if (cart.items.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Your cart is empty!')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Checkout successful! ✅'),
                      duration: Duration(seconds: 2)),
                );
                cart.clearCart();
              },
              icon: const Icon(Icons.check_circle),
              label: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
