import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background(
      {super.key,
      this.opacity = 1,
      this.color = const Color.fromRGBO(34, 31, 32, 1)});

  final double opacity;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(color: color),
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("images/backgroundImage.png"),
            scale: 1.5,
            repeat: ImageRepeat.repeat,
            opacity: opacity,
          ),
        ),
      ),
    ]);
  }
}
