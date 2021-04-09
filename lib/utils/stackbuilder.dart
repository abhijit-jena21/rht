import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rht/models/userpayment.dart';
import 'package:rht/screens/myprofile/stack.dart';
import 'package:rht/services/paymentservice.dart';
import '../screens/splash_screen.dart';
import 'package:flutter/material.dart';
import '../models/graph.dart';

class BarBuild extends StatefulWidget {
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
  final Function(int) notifyParent;
  BarBuild(
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
      this.notifyParent);
  @override
  _BarBuildState createState() => _BarBuildState();
}

class _BarBuildState extends State<BarBuild> {
  Dio dio = new Dio();
  product() async {
    final String pathUrl = "$serverLink/api/userreport";
    try {
      print('here22');

      // print();

      return await dio.post(pathUrl,
          data: {
            "_id": finalId,
            "index": widget.index,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } catch (e) {
      print('here33');
    }
  }

  var futurerest;

  Future<Graph> convert() async {
    var res = await product();
    print(res.data);
    print(res.data.runtimeType);
    final Map parsed = json.decode(res.toString());
    var rest = Graph.fromJson(parsed);
    return rest;
  }

  UserPayment payment = UserPayment();
  PaymentService paymentService = PaymentService();
  Future<UserPayment> paymentstatus() async {
    var res = await paymentService.userPayment(
        finalId, widget.productId, widget.duration, widget.checkoutDate);
    print(res.data);
    final Map parsed = json.decode(res.toString());
    return UserPayment.fromJson(parsed);
  }

  receivePaymentStatus() async {
    payment = await paymentstatus();
  }

  void initState() {
    super.initState();
    // receivePaymentStatus();
    futurerest = convert();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<Graph>(
          future: futurerest,
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Scaffold(
                    backgroundColor: Colors.white,
                    body: SingleChildScrollView(
                        child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Couldn't load details",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(color: Colors.black87),
                          ),
                        ],
                      )),
                    )));
              } else {
                print(snapshot.data);
                return Doughnut(
                    snapshot.data,
                    widget.index,
                    widget.count,
                    widget.duration,
                    widget.rent,
                    widget.img,
                    widget.deposit,
                    widget.locationId,
                    widget.name,
                    widget.productId,
                    widget.checkoutDate,
                    widget.notifyParent);
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                      child: Text(
                    'error',
                    style: Theme.of(context).textTheme.headline3,
                  )));
            } else {
              return Scaffold(
                  backgroundColor: Colors.white,
                  body: SingleChildScrollView(
                      child: Container(
                    height: MediaQuery.of(context).size.height,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Center(
                      child: Container(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  )));
            }
          }),
    );
  }
}
