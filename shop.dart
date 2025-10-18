//Kani nga code ang Shop page, diri makita ug ma-manage ang mga grocery items.
//Gamit ang ListView.builder para ipakita ang lista sa mga prutas ug gulay nga naay real images
//Pwede ka mo-add item gamit dialog (_showAddItemDialog) nga automatic mo-match ug image depende sa item name, mo-edit sa quantity before i-add sa cart (_showQuantityDialog), ug mo-delete item sa list.
//Ang cart updates kay handled by CartModel through Provider, so real-time ang changes.
//Overall, mura’g full-featured mini grocery store sa app, interactive, smart, ug user-friendly.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_drawer.dart';
import 'cart_model.dart';

class Shop extends StatefulWidget {
  const Shop({super.key});

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  final List<Map<String, dynamic>> groceries = [
    {
      'name': 'Fresh Apples',
      'price': 120.0,
      'quantity': 1,
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg'
    },
    {
      'name': 'Bananas',
      'price': 60.0,
      'quantity': 1,
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg'
    },
    {
      'name': 'Tomatoes',
      'price': 80.0,
      'quantity': 1,
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg'
    },
    {
      'name': 'Broccoli',
      'price': 150.0,
      'quantity': 1,
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/0/03/Broccoli_and_cross_section_edit.jpg'
    },
  ];

  final Map<String, String> imageMap = {
    'apple':
        'https://upload.wikimedia.org/wikipedia/commons/1/15/Red_Apple.jpg',
    'banana':
        'https://upload.wikimedia.org/wikipedia/commons/8/8a/Banana-Single.jpg',
    'tomato':
        'https://upload.wikimedia.org/wikipedia/commons/8/88/Bright_red_tomato_and_cross_section02.jpg',
    'broccoli':
        'https://upload.wikimedia.org/wikipedia/commons/0/03/Broccoli_and_cross_section_edit.jpg',
    'lemon':
        'https://upload.wikimedia.org/wikipedia/commons/8/89/Lemon_with_leaves.jpg',
    'mango':
        'https://upload.wikimedia.org/wikipedia/commons/9/90/Hapus_Mango.jpg',
    'orange':
        'https://upload.wikimedia.org/wikipedia/commons/c/c4/Orange-Fruit-Pieces.jpg',
  };

  void _addItemToCart(BuildContext context, Map<String, dynamic> item) {
    final cart = Provider.of<CartModel>(context, listen: false);
    cart.addItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('${item['name']} added to cart 🛒'),
          duration: const Duration(seconds: 2)),
    );
  }

  void _showQuantityDialog(BuildContext context, Map<String, dynamic> item) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text('Add ${item['name']}'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildNetworkImage(item['image'], height: 80),
                const SizedBox(height: 10),
                Text('₱${item['price']} per kg'),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon:
                            const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () {
                          if (quantity > 1) setState(() => quantity--);
                        }),
                    Text('$quantity',
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    IconButton(
                        icon: const Icon(Icons.add_circle,
                            color: Colors.deepPurple),
                        onPressed: () => setState(() => quantity++)),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  onPressed: () {
                    _addItemToCart(context, {
                      'name': item['name'],
                      'price': item['price'],
                      'quantity': quantity,
                      'image': item['image']
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Add to Cart')),
            ],
          );
        });
      },
    );
  }

  // Builds a network image widget with loading and error handling
  Widget _buildNetworkImage(String url, {double? width, double? height}) {
    return SizedBox(
      width: width ?? 50,
      height: height ?? 50,
      child: Image.network(
        url,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator(strokeWidth: 2));
        },
        errorBuilder: (context, error, stackTrace) {
          // debug print so you can check console for reason of failure
          // (e.g., DNS, blocked hotlink, CORS)
          // ignore: avoid_print
          print('Image load failed for $url -> $error');
          return Container(
            color: Colors.grey[200],
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.image_not_supported, color: Colors.grey, size: 28),
                SizedBox(height: 4),
                Text('Image failed',
                    style: TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          );
        },
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    String previewImage = imageMap.values.first; // default

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          void updatePreview() {
            final name = nameController.text.trim().toLowerCase();
            final match = imageMap.entries.firstWhere(
              (e) => name.contains(e.key),
              orElse: () => const MapEntry('default',
                  'https://upload.wikimedia.org/wikipedia/commons/3/3a/Placeholder_view_vector.svg'),
            );
            previewImage = match.value;
            setState(() {});
          }

          return AlertDialog(
            title: const Text('Add New Item'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Item Name'),
                      onChanged: (_) => updatePreview()),
                  TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price (₱)'),
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 12),
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Preview:',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  const SizedBox(height: 8),
                  _buildNetworkImage(previewImage, height: 100, width: 100),
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff89ea74)),
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        priceController.text.isEmpty) return;
                    final name = nameController.text.trim();
                    final lowerName = name.toLowerCase();
                    final image = imageMap.entries
                        .firstWhere((e) => lowerName.contains(e.key),
                            orElse: () => const MapEntry('default',
                                'https://upload.wikimedia.org/wikipedia/commons/3/3a/Placeholder_view_vector.svg'))
                        .value;
                    setState(() {
                      groceries.add({
                        'name': name,
                        'price': double.tryParse(priceController.text) ?? 0,
                        'quantity': 1,
                        'image': image
                      });
                    });
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('$name added with automatic image ✅')));
                  },
                  child: const Text('Add')),
            ],
          );
        });
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      groceries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Shop'),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                tooltip: 'Add Item',
                onPressed: () => _showAddItemDialog(context)),
          ]),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (context, index) {
          final item = groceries[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              leading: _buildNetworkImage(item['image'], width: 50, height: 50),
              title: Text(item['name'],
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('₱${item['price']} per kg'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                IconButton(
                    icon: const Icon(Icons.add_shopping_cart,
                        color: Colors.green),
                    onPressed: () => _showQuantityDialog(context, item)),
                IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteItem(index)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
