//Kini nga code mao ang Info page sa app 🧾; gigamit niya ang Scaffold para sa layout nga naay AppBar (title: Information), AppDrawer para sa navigation, ug body nga nagpakita sa text details gamit ang ListView. Iya lang gipakita ang basic info sa “My Grocery App” — unsa ni siya, unsay purpose (para sayon nga pag-shopping sa groceries), ug unsay features (browse, news updates, profile view).
import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Information'),
        backgroundColor: Colors.deepPurple,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            Text(
              'About My Grocery App',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'My Grocery App helps users browse, shop, and stay updated on the latest grocery products and offers. '
              'We aim to provide a convenient way to shop for your daily essentials from the comfort of your home.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Features:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
                '• Browse products easily\n• Stay updated with latest news\n• View your profile and history'),
          ],
        ),
      ),
    );
  }
}
