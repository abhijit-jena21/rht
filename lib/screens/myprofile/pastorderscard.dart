import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:intl/intl.dart";
import 'package:rht/screens/productdetailbuilder.dart';
import 'package:rht/services/uploadservice.dart';

class PastOrdersCard extends StatefulWidget {
  final int index;
  final int count;
  final int duration;
  final int rent;
  final String img;
  final int deposit;
  final String locationId;
  final String name;
  final String productId;
  final String checkoutDate;
  final String iscancelled;
  // final String locationId;
  // String imgPath,
  // final List<String> items;
  PastOrdersCard(
    this.index,
    this.count,
    this.duration,
    this.rent,
    this.img,
    this.deposit,
    this.locationId,
    this.name,
    this.productId,
    this.checkoutDate,
    this.iscancelled
  );
  @override
  _PastOrdersCardState createState() => _PastOrdersCardState();
}

class _PastOrdersCardState extends State<PastOrdersCard> {
  bool isFavourite = false;
  bool isFav = false;
  String response;
  int stock;
  int _count;
  DateTime deliveryDate;
  String month;
  int date;
  Dio dio = new Dio();
  UploadService cartService = new UploadService();

  // int cast(x) => x is int ? x : null;

  void initState() {
    super.initState();
    // print("result"+result.toString());
    parseDate();
  }

  void parseDate() {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(widget.checkoutDate);
    deliveryDate = tempDate.add(Duration(days: 3));
    print(widget.checkoutDate);

    // print(DateTime.now());
    print(deliveryDate.month);
    List months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    month = months[deliveryDate.month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0, left: 5.0, right: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDetailBuilder(widget.productId)));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: IntrinsicHeight(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IntrinsicHeight(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                  // constraints: BoxConstraints.loose(Size.fromHeight(100)),
                                  height:
                                      MediaQuery.of(context).size.width * 0.25,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 0),
                                  // padding: EdgeInsets.symmetric(
                                  //     horizontal: 20, vertical: 10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(widget.img ??
                                              "https://4.bp.blogspot.com/-1f1SDFIx3dY/Uh92eZAQ90I/AAAAAAAAHM4/5oiB4zC_tQ4/s1600/Photo-Background-White4.jpg"),
                                          fit: BoxFit.cover))),
                              SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  
                                  Text(
                                    "Qty: ${widget.count}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(color: Colors.black87),
                                  ),
                                ],
                              ),
                              // SizedBox(
                              //   height: 10,
                              // )
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              // mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  // width: MediaQuery.of(context).size.width * 0.55,
                                  child: Text(
                                    "${widget.name}",
                                    // maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(
                                            color: Theme.of(context).accentColor,
                                            // fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text("Rent:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ₹${widget.rent}/month",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                // fontWeight: FontWeight.w800,
                                                color: Colors.black87,
                                              )),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Text("Deposit:",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(color: Colors.black54)),
                                    ),
                                    Container(
                                      child: Text(" ₹${widget.deposit}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  // fontWeight: FontWeight.w800,
                                                  color: Colors.black87)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10, 
                                ),
                                // Container(
                                //   child: Text(
                                //       "Rented for ${widget.duration} months",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .caption
                                //           .copyWith(
                                //               fontWeight: FontWeight.normal,
                                //               color: Colors.black54)),
                                // ),
                                // SizedBox(height: 10,),
                                // Container(
                                //   child: Text(
                                //       "Delivery by ${deliveryDate.day} $month",
                                //       style: Theme.of(context)
                                //           .textTheme
                                //           .caption
                                //           .copyWith(
                                //               fontWeight: FontWeight.normal,
                                //               color: Colors.green)),
                                // ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                      child:  Text(
                                        widget.iscancelled=="true"?"Cancelled":"",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(
                                                  // fontWeight: FontWeight.w800,
                                                  color: Colors.red)),
                                    ),// stockWidget()
                              ],
                            ),
                          ],
                        ),
                      ]),
                ))));
  }
}
