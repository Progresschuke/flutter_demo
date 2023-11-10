import 'package:flutter/material.dart';
import 'package:food_app/widgets/rating/clipper.dart';

class RatingStar extends StatelessWidget {
  const RatingStar({
    super.key,
    required this.rating,
    required this.ratingCount,
    this.size = 18,
  });

  final num rating;
  final double size;
  final int? ratingCount;

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];

    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(
          const Icon(
            Icons.star,
            color: Colors.amber,
            size: 18,
          ),
        );
      } else if (i == realNumber) {
        starList.add(SizedBox(
          height: size,
          width: size,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Icon(
                Icons.star,
                color: Colors.amber,
                size: size,
              ),
              ClipRect(
                clipper: Clipper(
                  part: partNumber,
                ),
                child: Icon(
                  Icons.star,
                  color: Colors.grey,
                  size: size,
                ),
              )
            ],
          ),
        ));
      } else {
        starList.add(
          Icon(
            Icons.star,
            color: Colors.grey,
            size: size,
          ),
        );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: starList,
    );
  }
}
