import 'package:flutter/material.dart';
import '../../services/carousel_service.dart';
import 'dart:convert';

import '../../widgets/appbar.dart';
import '../../widgets/carousel.dart';
import './grid.dart';
import './locationpicker.dart';

class LandingPage extends StatefulWidget {
  final String title;
  final String locationId;
  LandingPage({this.title, this.locationId});
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  CarouselService _carouselService = CarouselService();

  var items = [];
  String _title;
  // String _cityname;
  void initState() {
    super.initState();
    _getAllSliders();
    // _title = widget.title;
  }

  _getAllSliders() async {
    var sliders = await _carouselService.getSliders();
    print(sliders);
    var result = json.decode(sliders.body);
    print(result);
    result['carousel'].forEach((data) {
      if (mounted) {
        setState(() {
          items.add(NetworkImage(data));
        });
      }
    });
  }

  String featuredlist() {
    setState(() {
      _title = widget.title;
    });
    return _title;
  }

  @override
  Widget build(BuildContext context) {
    String _cityname = featuredlist();
    return Scaffold(
      appBar: MyAppBar(),
      // bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            LocationPicker(
              location: _title,
              locationId: widget.locationId,
            ),
            imageCarousel(items),
            GridOne(widget.locationId),
            // Center(
            //   child: Text(
            //     "Featured in $_cityname",
            //     style: Theme.of(context).textTheme.bodyText1,
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
