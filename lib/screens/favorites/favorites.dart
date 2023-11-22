import 'package:fast_jobs/screens/favorites/widgets/favorites_list.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: const Padding(
            padding: EdgeInsets.all(10),
            child: FavoritesList(),
          ),
        ),
      );
}
