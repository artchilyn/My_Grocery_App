//Kani nga code mao ang Newsstand page sa app, diri ipakita ang mga grocery news ug tips.
//Gigamit ang ListView.builder para automatic nga i-display ang list sa mga balita gikan sa news list.
//Each news item ipakita sulod sa Card nga naay title, description, ug newspaper icon.
//Naay AppBar (title: “Newsstand”) ug AppDrawer para navigation.

import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Newsstand extends StatelessWidget {
  const Newsstand({super.key});

  final List<Map<String, String>> news = const [
    {
      'title': 'Fresh Market Opens in Town',
      'description':
          'A new grocery store opens offering organic produce and local products.'
    },
    {
      'title': 'Weekly Discount Deals!',
      'description':
          'Save up to 30% on selected vegetables and fruits this weekend.'
    },
    {
      'title': 'Healthy Grocery Tips',
      'description':
          'Learn how to pick the freshest and most nutritious grocery items.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsstand'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const AppDrawer(),
      body: ListView.builder(
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 3,
            child: ListTile(
              title: Text(item['title']!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(item['description']!),
              leading: const Icon(Icons.newspaper, color: Colors.deepPurple),
            ),
          );
        },
      ),
    );
  }
}
