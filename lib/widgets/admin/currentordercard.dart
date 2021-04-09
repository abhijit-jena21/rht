import 'dart:async';

import "package:flutter/material.dart";
import "package:dio/dio.dart";
import "package:intl/intl.dart";
import 'package:rht/models/currentorders.dart';
import 'package:rht/utils/productdetailbuilder.dart';
import 'package:rht/services/paymentservice.dart';
import 'package:rht/services/uploadservice.dart';

class CurrentOrderCard extends StatefulWidget {
  final int index;
  final String userid;
  final Currentorder snapshot;
  // final String locationId;
  // String imgPath,
  // final List<String> items;
  CurrentOrderCard(this.index, this.userid, this.snapshot);
  @override
  _CurrentOrderCardState createState() => _CurrentOrderCardState();
}

class _CurrentOrderCardState extends State<CurrentOrderCard> {
  bool isFavourite = false;
  bool isFav = false;
  String response;
  int stock;
  DateTime deliveryDate;
  String month;
  int date;
  int due;
  Dio dio = new Dio();
  UploadService cartService = new UploadService();
  PaymentService paymentService = PaymentService();
  final StreamController streamController = StreamController.broadcast();
  // int cast(x) => x is int ? x : null;

  void initState() {
    super.initState();
    due = widget.snapshot.due;
    print("due"+due.toString());
    streamController.sink.add(due);
    print(due);
    // print("result"+result.toString());
    parseDate();
  }

  void dispose() {
    super.dispose();
    streamController.close();
  }

  void parseDate() {
    DateTime tempDate =
        new DateFormat("yyyy-MM-dd").parse(widget.snapshot.checkoutdate);
    deliveryDate = tempDate.add(Duration(days: 3));
    print(widget.snapshot.checkoutdate);

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
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ProductDetailBuilder(productId:widget.snapshot.pId)));
            },
            child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade200, width: 2),
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      IntrinsicHeight(
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
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 0),
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(widget
                                                        .snapshot.img ??
                                                    "https://4.bp.blogspot.com/-1f1SDFIx3dY/Uh92eZAQ90I/AAAAAAAAHM4/5oiB4zC_tQ4/s1600/Photo-Background-White4.jpg"),
                                                fit: BoxFit.cover))),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Qty: ${widget.snapshot.count}",
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
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        // width: MediaQuery.of(context).size.width * 0.55,
                                        child: Text(
                                          "${widget.snapshot.name}",
                                          // maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  color: Theme.of(context)
                                                      .accentColor,
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
                                                    .copyWith(
                                                        color: Colors.black54)),
                                          ),
                                          Container(
                                            child: Text(
                                                " ₹${widget.snapshot.iRent}/month",
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
                                                    .copyWith(
                                                        color: Colors.black54)),
                                          ),
                                          Container(
                                            child: Text(
                                                " ₹${widget.snapshot.deposit}",
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        child: Text(
                                            widget.snapshot.iscancelled ==
                                                    "true"
                                                ? "Cancelled"
                                                : "",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                    // fontWeight: FontWeight.w800,
                                                    color: Colors.red)),
                                      ), // stockWidget()
                                    ],
                                  ),
                                ],
                              ),
                            ]),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Text(
                                      "Due:",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          .copyWith(color: Colors.black87),
                                    )),
                                Container(
                                    //  margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    child: StreamBuilder<Object>(
                                        stream: streamController.stream,
                                        builder: (context, snapshot) {
                                          print("due2" +
                                              snapshot.data.toString());
                                          return Text(
                                            snapshot.data.toString()!="0"?"₹$due":"Collected ",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1
                                                .copyWith(
                                                    color: Colors.black87),
                                          );
                                        })),
                              ],
                            ),
                            // ignore: deprecated_member_use
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              // ignore: deprecated_member_use
                              child: due!=0?RaisedButton(
                                  elevation: 0,
                                  color: Theme.of(context).buttonColor,
                                  child: Text(
                                    "Collect Rent",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                  onPressed: () async {
                                    paymentService
                                        .adminPayment(
                                            widget.userid,
                                            widget.snapshot.pId,
                                            widget.snapshot.duration,
                                            widget.snapshot.checkoutdate)
                                        .whenComplete(() {
                                          setState(() {
                                            due = 0;
                                          });
                                      
                                      streamController.sink.add(due);
                                    });
                                  }):Container()
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}
