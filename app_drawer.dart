//Kani nga Flutter code sir is naghimo syag custom navigation drawer nga naay wave-shaped header ug mga menu item, gamit ang Drawer ug ListView para ipakita ang header nga naay background image, green overlay, ug title sa app, unya ubos ani ang mga ListTile like (Shop, Newsstand, Info, Profile, My Cart) nga mo-navigate sa different pages, while ang _WaveClipper naghimo sa wave shaped gamit ang quadraticBezierTo.

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
         
          ClipPath(
            clipper: _WaveClipper(),
            child: DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://images.unsplash.com/photo-1606787366850-de6330128bfc?auto=format&fit=crop&w=1200&q=80',
                  ), 
                  fit: BoxFit.cover,
                ),
              ),
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.4),
                    ),
                  ),

                  
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'My Grocery App',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 3,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Fresh • Fast • Friendly',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.store, color: Colors.deepPurple),
            title: const Text('Shop'),
            onTap: () => Navigator.pushNamed(context, '/shop'),
          ),
          ListTile(
            leading: const Icon(Icons.newspaper, color: Colors.deepPurple),
            title: const Text('Newsstand'),
            onTap: () => Navigator.pushNamed(context, '/newsstand'),
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.deepPurple),
            title: const Text('Info'),
            onTap: () => Navigator.pushNamed(context, '/info'),
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text('Profile'),
            onTap: () => Navigator.pushNamed(context, '/profile'),
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
            title: const Text('My Cart'),
            onTap: () => Navigator.pushReplacementNamed(context, '/cart'),
          ),
        ],
      ),
    );
  }
}


class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 40);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstEndPoint = Offset(size.width / 2, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    var secondControlPoint = Offset(size.width * 3 / 4, size.height - 70);
    var secondEndPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
