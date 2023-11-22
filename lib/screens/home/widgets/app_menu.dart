import 'package:flutter/material.dart';

import '../../favorites/favorites.dart';

class AppMenu extends StatelessWidget {
  const AppMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              child: Container(
                color: Colors.deepPurple,
                padding: const EdgeInsets.all(10),
                child: const Center(
                  child: Image(
                    image: AssetImage('./assets/fast_icon.png'),
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Random jokes'),
              leading: const Icon(Icons.casino),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              title: const Text('Favorite jokes'),
              leading: const Icon(Icons.star),
              onTap: () => Navigator.of(context)
                ..pop()
                ..push(
                  MaterialPageRoute(
                    builder: (context) => const Favorites(),
                  ),
                ),
            ),
          ],
        ),
      );
}
