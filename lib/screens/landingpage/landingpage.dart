import 'package:flutter/material.dart';
import '../../services/carousel_service.dart';
import 'dart:convert';

import '../../widgets/appbar.dart';
import '../../widgets/carousel.dart';
import './grid.dart';
import './locationpicker.dart';

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
    result['carousel'].forEach((data) {
      if (mounted) {
        setState(() {
          items.add(NetworkImage(data));
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
          children: [
            LocationPicker(),
            imageCarousel(items),
            GridOne()],
        ),
      ),
    );
  }
}
