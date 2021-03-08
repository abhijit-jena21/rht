import 'package:flutter/material.dart';
import '../../services/carousel_service.dart';
import 'dart:convert';

import '../../widgets/appbar.dart';
import '../../widgets/carousel.dart';
import './grid.dart';
import './locationpicker.dart';

class LandingPage extends StatefulWidget {
  final String location;
  final String locationId;
  final String userId;
  final void Function(int, int, String, TabController) onButtonTapped;
  // final TabController tabController;
  LandingPage(
      {this.location, this.locationId, this.userId, this.onButtonTapped,});
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
    // print(sliders);
    var result = json.decode(sliders.body);
    // print(result);
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
      _title = widget.location;
    });
    return _title;
  }

  @override
  Widget build(BuildContext context) {
    print('landing' + widget.userId);
    // String _cityname = featuredlist();
    return Scaffold(
      appBar: MyAppBar(),
      // bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            LocationPicker(
              location: widget.location,
              locationId: widget.locationId,
              userId: widget.userId,
            ),
            imageCarousel(items),
            GridOne(widget.locationId, widget.userId, widget.onButtonTapped),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              color: Colors.amber.shade50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Safety Assured",
                  style: Theme.of(context).textTheme.headline3.copyWith(color: Colors.amber.shade900),),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        // color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: 25,
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage("./assets/images/sanitise.jpeg"),),
                            SizedBox(width: 20,),
                            Text("Sanitised\nProducts",
                            style: Theme.of(context).textTheme.bodyText1,),
                          ],),),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(radius: 25,
                            backgroundColor: Colors.black,
                            backgroundImage: AssetImage("./assets/images/delivery.jpeg"),),
                            SizedBox(width: 20,),
                            Text("Hygienic\nDelivery",
                            style: Theme.of(context).textTheme.bodyText1,),
                          ],),)
                  ],)
                ],),
            ),
            
            SizedBox(height: 20,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text("Why renting is better",
            style: Theme.of(context).textTheme.headline3,),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              height: 150,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Container(
                    color: Colors.amber.shade50,
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Live Better. Now.",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text("Create your dream space today. In a budget.",
                          style: Theme.of(context).textTheme.bodyText1,)
                        ],),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    color: Colors.amber.shade50,
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Have everything without buying.",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text("Create your perfect home at a fraction of the cost and effort.",
                          style: Theme.of(context).textTheme.bodyText1,)
                        ],),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    color: Colors.amber.shade50,
                    width: 200,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Change as your needs evolve.",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                            color: Theme.of(context).accentColor,
                            fontWeight: FontWeight.bold),),
                          SizedBox(height: 10,),
                          Text("Upgrade as you evolve. Change your products as per your needs.",
                          style: Theme.of(context).textTheme.bodyText1,)
                        ],),
                  ),
                ],)),
          ],
        ),
      ),
    );
  }
}
