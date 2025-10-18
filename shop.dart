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
    Provider.of<CartModel>(context, listen: false).addItem(item);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} added to cart 🛒')),
    );
  }

  void _showQuantityDialog(BuildContext context, Map<String, dynamic> item) {
    int quantity = 1;
    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          title: Text('Add ${item['name']}'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            _buildImage(item['image'], h: 80),
            const SizedBox(height: 10),
            Text('₱${item['price']} per kg'),
            const SizedBox(height: 15),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                  icon: const Icon(Icons.remove_circle, color: Colors.red),
                  onPressed: () => setState(
                      () => quantity = (quantity > 1) ? quantity - 1 : 1)),
              Text('$quantity',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                  icon: const Icon(Icons.add_circle, color: Colors.deepPurple),
                  onPressed: () => setState(() => quantity++)),
            ])
          ]),
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
      }),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    final nameController = TextEditingController();
    final priceController = TextEditingController();
    String preview = imageMap.values.first;

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(builder: (context, setDialog) {
        void updatePreview() {
          final name = nameController.text.trim().toLowerCase();
          final match = imageMap.entries.firstWhere(
            (e) => name.contains(e.key),
            orElse: () => const MapEntry('default',
                'https://upload.wikimedia.org/wikipedia/commons/3/3a/Placeholder_view_vector.svg'),
          );
          setDialog(() => preview = match.value);
        }

        return AlertDialog(
          title: const Text('Add New Item'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                onChanged: (_) => updatePreview()),
            TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price (₱)'),
                keyboardType: TextInputType.number),
            const SizedBox(height: 12),
            _buildImage(preview, h: 100, w: 100),
          ]),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff89ea74)),
                onPressed: () {
                  if (nameController.text.isEmpty ||
                      priceController.text.isEmpty) return;
                  final name = nameController.text.trim();
                  final image = imageMap.entries
                      .firstWhere((e) => name.toLowerCase().contains(e.key),
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
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('$name added successfully ✅')),
                  );
                },
                child: const Text('Add')),
          ],
        );
      }),
    );
  }

  void _deleteItem(int i) => setState(() => groceries.removeAt(i));

  Widget _buildImage(String url, {double? w, double? h}) => SizedBox(
        width: w ?? 50,
        height: h ?? 50,
        child: Image.network(url,
            fit: BoxFit.cover,
            loadingBuilder: (c, child, l) => l == null
                ? child
                : const Center(
                    child: CircularProgressIndicator(strokeWidth: 2)),
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported, color: Colors.grey)),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Shop'),
          backgroundColor: Colors.deepPurple,
          actions: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => _showAddItemDialog(context)),
          ]),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: groceries.length,
        itemBuilder: (_, i) {
          final item = groceries[i];
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              leading: _buildImage(item['image']),
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
                    onPressed: () => _deleteItem(i)),
              ]),
            ),
          );
        },
      ),
    );
  }
}
