import 'package:flutter/material.dart';
import 'package:rht/services/carousel_service.dart';
import 'dart:convert';

import '../widgets/appbar.dart';
import '../widgets/carousel.dart';
import '../widgets/grid.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  CarouselService _carouselService = CarouselService();

  var items = [];

  void initState() {
    super.initState();
    _getAllSliders();
  }

  _getAllSliders() async {
    var sliders = await _carouselService.getSliders();
    var result = json.decode(sliders.body);
    result['data'].forEach((data) {
      if (mounted) {
        setState(() {
          items.add(NetworkImage(data['image_url']));
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      // bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [imageCarousel(items), GridOne()],
        ),
      ),
    );
  }
}
