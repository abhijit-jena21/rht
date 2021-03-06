import 'package:flutter/material.dart';
import 'package:rht/screens/splash_screen.dart';
import '../../services/carousel_service.dart';
import 'dart:convert';

import '../../widgets/appbar.dart';
import '../../widgets/carousel.dart';
import '../../widgets/grid.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LandingPage extends StatefulWidget {
  final String location;
  final String locationId;
  final String userId;
  final void Function(int, int, String) onButtonTapped;
  // final TabController tabController;
  LandingPage({
    this.location,
    this.locationId,
    this.userId,
    this.onButtonTapped,
  });
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  CarouselService _carouselService = CarouselService();

  var items = [];
  // String _cityname;
  void initState() {
    super.initState();
    _getAllSliders();
    // _title = widget.title;
  }

  _getAllSliders() async {
    var sliders = await _carouselService.getSliders();
    // print(sliders);
    try {
      var result = json.decode(sliders.body);
      // print(result);
      result['carousel'].forEach((data) {
        if (mounted) {
          setState(() {
            items.add(NetworkImage(data));
          });
        }
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Something went wrong",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey.shade900,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('landing' + finalId);
    print('landinglocation' + finalLocation);
    // String _cityname = featuredlist();
    return Scaffold(
      appBar: MyAppBar(
        location: widget.location,
        locationId: widget.locationId,
        userId: finalId,
      ),
      // bottomNavigationBar: MyBottomNavigationBar(),
      body: Container(
        child: ListView(
          shrinkWrap: true,
          children: [
            // LocationPicker(
            //   location: widget.location,
            //   locationId: widget.locationId,
            //   userId: widget.userId,
            // ),
            imageCarousel(items),
            GridOne(widget.locationId, finalId, widget.onButtonTapped),

            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05,
                  vertical: 20),
              color: Color(0x112873f0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Safety Assured",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Theme.of(context).primaryColor)),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.05,
                            vertical: 10),
                        // color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.06,
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  AssetImage("./assets/images/sanitise.jpeg"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Text("Sanitised\nProducts",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(color: Colors.black87)),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: MediaQuery.of(context).size.width * 0.06,
                              backgroundColor: Colors.black,
                              backgroundImage:
                                  AssetImage("./assets/images/delivery.jpeg"),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.06,
                            ),
                            Text(
                              "Hygienic\nDelivery",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.black87),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Why renting is better",
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                height: MediaQuery.of(context).size.height * 0.23,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    Container(
                      color: Color(0x112873f0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Live Better. Now.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Create your dream space today. In a budget.",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      color: Color(0x112873f0),
                      width: MediaQuery.of(context).size.width * 0.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Have everything without buying.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(height: 10),
                          Text(
                              "Create your perfect home at a fraction of the cost and effort.",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.black87))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      color: Color(0x112873f0),
                      width: 200,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Change as your needs evolve.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: Theme.of(context).primaryColor),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Upgrade as you evolve. Change your products as per your needs.",
                            style: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(color: Colors.black87),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
