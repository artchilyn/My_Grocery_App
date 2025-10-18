//Kani pud nga code mao ang Profile page sa app, diri makita ang personal info sa user.
//Naay curved background header gamit ang BottomCurveClipper nga naghatag ug wavy effect, plus naa pud ang profile picture, pangalan, ug short bio sa center.
//Sa ubos, gipakita ang details gamit ListTile (email, phone, address, ug traits).
//Gigamit ang AppDrawer para easy navigation ug SingleChildScrollView aron scrollable ang layout.
//Overall, mura ni’g clean, aesthetic profile layout.

import 'package:flutter/material.dart';
import 'app_drawer.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: const Color(0xff8ef4ad),
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(
                height: 250,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1542838132-92c53300491e?auto=format&fit=crop&w=1200&q=80',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8,
                            offset: const Offset(2, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/4140/4140061.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.account_circle,
                                  size: 100, color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Archilyn Andrica',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'BSIT Student | Grocery App Developer',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            offset: Offset(1, 1),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

        
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Divider(height: 40, thickness: 1),
                  ListTile(
                    leading: Icon(Icons.email, color: Colors.deepPurple),
                    title: Text('archilyn.andrica@example.com'),
                  ),
                  ListTile(
                    leading: Icon(Icons.phone, color: Colors.deepPurple),
                    title: Text('+63 912 345 6789'),
                  ),
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.deepPurple),
                    title: Text('Cabadbaran City, Agusan del Norte'),
                  ),
                  ListTile(
                    leading: Icon(Icons.favorite, color: Colors.deepPurple),
                    title: Text('Humble | Responsible | Family-Oriented'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 40,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
