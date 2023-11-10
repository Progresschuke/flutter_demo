import 'package:flutter/material.dart';

class Clipper extends CustomClipper<Rect> {
  Clipper({required this.part});

  final int part;

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(
      (size.width / 10) * part,
      0,
      size.width,
      size.height,
    );
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) => true;
}
