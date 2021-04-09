import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget imageCarousel(items) => Container(
  height: 200.0,
  child: Carousel(
    boxFit: BoxFit.cover,
    images: items,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
    showIndicator: true,
    autoplay: false,
    dotBgColor: Colors.transparent,
    dotSize: 6,
    dotColor: Colors.white.withOpacity(0.7),
    dotIncreaseSize: 2,
  ),
);
