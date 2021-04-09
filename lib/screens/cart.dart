import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rht/screens/checkout.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/screens/starter.dart';
import '../services/usercheckservice.dart';
import '../models/cartproduct.dart';
import '../services/cartservice.dart';
import 'package:dio/dio.dart';
import '../utils/cartbuilder.dart';
import '../utils/cartbuilder.dart';
import 'login.dart';

class Res {
  String error;
  String result;

  Res({this.error, this.result});

  factory Res.fromJson(Map<String, dynamic> json) {
    return Res(error: json['error'], result: json['result']);
  }
}

class Cart extends StatefulWidget {
  final String userId;
  Cart({this.userId});
  @override
  _CartState createState() => _CartState();
} 

class _CartState extends State<Cart> {
  final GlobalKey<ScaffoldState> _scaffoldKey2 = new GlobalKey<ScaffoldState>();
  final StreamController streamController = StreamController.broadcast();
  final StreamController streamController2 = StreamController.broadcast();
  final StreamController streamController3 = StreamController.broadcast();
  Dio dio = new Dio();
  bool exist;
  int cartSum = 0;
  CartService cartService = new CartService();
  var response = false;
  Usercheck usercheck = Usercheck();
  var futureProducts;
  var res = Res();
  bool cartEmpty = true;
  void initState() {
    super.initState();
    if (finalPhone == null) {
      exist = false;
      {
        print("User doesn\'t exist");
      }
    } else {
      exist = true;
    }
    setState(() {
      futureProducts = cartService.getCartProducts(widget.userId);
      receiveProducts();
      // cartSum = sumOfRent();
    });
  }

  void receiveProducts() async {
    var products = await cartService.getCartProducts(widget.userId);
    if (products != null)
      setState(() {
        cartEmpty = false;
      });
  }

  void dispose() {
    super.dispose();
    streamController.close();
    streamController2.close();
    streamController3.close();
  }

  void updateCartSum(int receivedSum) {
    setState(() {
      cartSum = receivedSum;
    });
  }

  void showActionSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      backgroundColor: Colors.black87,
      margin: EdgeInsets.fromLTRB(20, 0, 20, 70),
      behavior: SnackBarBehavior.floating,
      content: Text(
        "Some Products in cart are unavailable",
        style:
            Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
      ),
    );
    // ignore: deprecated_member_use
    _scaffoldKey2.currentState.showSnackBar(snackBar);
  }

  void refresh() {
    cartEmpty = true;
  }

  // ignore: missing_return
  Widget proceedButton(BuildContext context) {
    void Function() _onPressed;
    _onPressed = () async {
      var response = await cartService.respondStock(widget.userId);
      print(response);
      print(response.runtimeType);
      if (response.compareTo("fail") == 0) {
        print("iamhere");
        showActionSnackBar(context);
      } else if (response.compareTo("success") == 0) {
        print("mehere");
        if (finalPhone == null) {
          print(finalPhone.toString());
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => LoginScreen("/cart")));
        } else
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CheckOut()));
      }
    };
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width * 0.4,
      // ignore: deprecated_member_use
      child: RaisedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        color: Theme.of(context).buttonColor,
        onPressed: _onPressed,
        child: Text(
          'PROCEED',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey2,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Starter(
                          location: finalLocation,
                          locationId: finalLocationId,
                          userId: finalId)),
                  (_) => false);
            },
          ),
          title: Text(
            "My Cart",
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            FutureBuilder<List<CartProduct>>(
                future: futureProducts,
                // ignore: missing_return
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return Container(
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "././assets/images/empty.png",
                              height: 200,
                            ),
                            Text(
                              "Your cart is empty",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(color: Colors.black87),
                            ),
                          ],
                        )),
                      );
                    } else {
                      print(snapshot.data);
                      return Container(
                          child: CartBuilder(snapshot.data, widget.userId,
                              streamController, streamController2, streamController3));
                    }
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return Text(
                      'error',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else {
                    return Container(
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
                    );
                  }
                }),
          ],
        )),
        bottomSheet: StreamBuilder<Object>(
            stream: streamController3.stream,
            builder: (context, snapshot) {
              return Container(
                color: Color(0Xfff2f2f2),
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: snapshot.data==true?Container():Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: StreamBuilder<Object>(
                              stream: streamController.stream,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data != null
                                      ? 'Rent: ₹${snapshot.data}/mo'
                                      : "",
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontFamily: "Montserrat"),
                                );
                              }),
                        ),
                        Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: StreamBuilder<Object>(
                              stream: streamController2.stream,
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.data != null
                                      ? 'Deposit: ₹${snapshot.data}'
                                      : '',
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontFamily: "Montserrat"),
                                );
                              }),
                        ),
                      ],
                    ),
                    cartEmpty == false ? proceedButton(context) : Container()
                  ],
                ),
              );
            }),
      ),
    );
  }
}
