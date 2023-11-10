import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.image, required this.child});

  final ImageProvider image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget buildBackground = ShaderMask(
      shaderCallback: (bounds) => LinearGradient(colors: [
        Theme.of(context).colorScheme.background.withOpacity(0.3),
        Theme.of(context).colorScheme.background.withOpacity(0.9)
      ], begin: Alignment.center, end: Alignment.bottomCenter)
          .createShader(bounds),
      blendMode: BlendMode.darken,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.background.withOpacity(0.5),
                  BlendMode.darken)),
        ),
      ),
    );

    return Stack(
      children: [buildBackground, child],
    );
  }
}
