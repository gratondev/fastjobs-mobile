import 'package:flutter/material.dart';

class JokeCardImage extends StatelessWidget {
  const JokeCardImage({Key? key, required this.bgColor, required this.image});

  final Color bgColor;
  final Image image;

  @override
  Widget build(BuildContext context) => AspectRatio(
        aspectRatio: 2,
        child: Container(
          color: Colors.blue.shade900,
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: Image(
              image: AssetImage('assets/fast_icon.png'),
              color: Colors.white,
            ),
          ),
        ),
      );
}
