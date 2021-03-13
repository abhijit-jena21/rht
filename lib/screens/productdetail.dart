import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../screens/splash_screen.dart';
import '../services/cartservice.dart';

import '../models/product.dart';
import '../services/wishlistservice.dart';
import '../utils/sliderutil.dart';
import 'cart.dart';

class ProductDetail extends StatefulWidget {
  final String userId;
  final String productId;
  final String name;
  final List<String> img;
  final String details;
  final int price;
  final int rent;
  final int duration;
  final String locationId;
  final List<String> items;
  ProductDetail(this.userId, this.productId, this.name, this.img, this.details,
      this.price, this.rent, this.duration, this.locationId, this.items);

  @override
  _ProductDetailState createState() => _ProductDetailState(this.rent);
}

class _ProductDetailState extends State<ProductDetail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int calculatedRent;
  _ProductDetailState(this.calculatedRent);

  Product product = new Product();
  // MySlider mySlider;
  var indexTop = 3;
  int duration = 24;
  bool isFavourite;
  bool isFav = false;
  String response;
  Dio dio = new Dio();
  List items = [];
  WishlistService wishlistService = new WishlistService();
  CartService cartService = new CartService();

  List<Product> wishlistedProducts;
  // Product productDetails;

  Widget buildLabel({String label}) => Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        // width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
      );

  Widget buildSliderTopLabel() {
    final labels = ['3+', '    6+', '      12+', '24+'];
    final double min = 0;
    final double max = labels.length - 1.0;
    final divisions = labels.length - 1;
    return Column(
      children: [
        Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: SliderUtil.modelBuilder(
                // ignore: missing_return
                labels, (index, label) {
              // final isSelected = index <= indexTop;
              return buildLabel(label: label);
            }),
          ),
        ),
        Slider(
            value: indexTop.toDouble(),
            min: min,
            max: max,
            divisions: divisions,
            activeColor: Theme.of(context).accentColor,
            inactiveColor: Colors.amber.shade200,
            onChanged: (newRent) {
              print(newRent);
              setState(
                () {
                  this.indexTop = newRent.toInt();

                  if (indexTop == 0) {
                    calculatedRent = (widget.rent * 1.15).toInt();
                    duration = 3;
                  } else if (indexTop == 1) {
                    calculatedRent = (widget.rent * 1.1).toInt();
                    duration = 6;
                  } else if (indexTop == 2) {
                    calculatedRent = (widget.rent * 1.05).toInt();
                    duration = 12;
                  } else if (indexTop == 3) {
                    calculatedRent = widget.rent;
                    duration = 24;
                  }
                },
              );
            } // label: labels[indexTop],
            ),
      ],
    );
  }

  Widget imageCarousel(items) => Container(
        height: 100.0,
        child: Carousel(
          boxFit: BoxFit.contain,
          images: items,
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          showIndicator: false,
          autoplay: false,
        ),
      );

  void initState() {
    super.initState();
    wishlistService.getWishlistedProducts(finalId).then((result) {
      if (this.mounted) {
        setState(() {
          wishlistedProducts = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var images = [];

    if (wishlistedProducts != null) {
      for (var index = 0; index < wishlistedProducts.length; index++) {
        if (widget.productId == wishlistedProducts[index].sId) {
          isFav = true;
          break;
        } else
          isFav = false;
      }
    }
    // calculatedRent = widget.rent;
    widget.img.forEach((data) {
      images.add(NetworkImage(data));
    });

    void showActionSnackBar(BuildContext context) {
      final snackBar = SnackBar(
        margin: EdgeInsets.fromLTRB(20, 0, 20, 70),
        // padding: EdgeInsets.symmetric(horizontal: 20),
        behavior: SnackBarBehavior.floating,
        content: Text(
          "Added to Cart",
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
        action: SnackBarAction(
          label: "View Cart",
          textColor: Color(0xFFFFA751),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Cart(
                          userId: finalId,
                        )));
          },
        ),
      );
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }

    Widget addToCart(BuildContext context) {
      Color conditionalColor;
      void Function() _onPressed;
      print("locationid" + widget.locationId);
      print("shared" + finalLocationId);
      if (widget.items.length == 0 || (widget.locationId != finalLocationId)) {
        setState(() {
          conditionalColor = Colors.grey;
          print("i");
          _onPressed = null;
        });
      } else if (widget.items.length > 0) {
        setState(() {
          print("am");
          conditionalColor = Theme.of(context).accentColor;
          var now = DateTime.now();
          var formatter = DateFormat('yyyy-MM-dd');
          String formattedDate = formatter.format(now);
          String finalDate = '${formattedDate}T00:00:00.000Z';
          _onPressed = () async {
            var response = await cartService.addToCart(
                finalId,
                widget.productId,
                finalLocationId,
                widget.name,
                1,
                duration,
                calculatedRent,
                widget.img[0],
                finalDate);
            print(response.toString());
            if (response.toString() == "New product added" ||
                response.toString() == "Count of product increased")
              showActionSnackBar(context);
          };
        });
      }
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.4,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: conditionalColor,
          onPressed: _onPressed,
          child: Text(
            'Add to Cart',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: "Montserrat"),
          ),
        ),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: Color(0xFFEF7532),
              // size: 18,
            ),
            onPressed: () async {
              isFavourite = await wishlistService.responseFromWishlist(
                  finalId, widget.productId, isFav);
              wishlistedProducts =
                  await wishlistService.getWishlistedProducts(finalId);
              print("2");
              print("sss" + isFavourite.toString());
              setState(() {
                isFav = isFavourite;
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              height: 300,
              width: double.infinity,
              child: imageCarousel(images),
            ),
            SizedBox(
              height: 10,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                alignment: Alignment.centerLeft,
                child: Text('${widget.name}',
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.headline2)),
            if (widget.items.length == 0)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                color: Colors.redAccent,
                child: Text(
                  "Out of stock",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            if (widget.locationId != finalLocationId)
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                color: Colors.amber[100],
                child: Text(
                  "This product isn't available in this city",
                  style: TextStyle(
                      color: Theme.of(context).accentColor, fontSize: 12),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  // height: 50,
                  // width: double.infinity/2,
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text('₹ $calculatedRent',
                            style: Theme.of(context).textTheme.headline1),
                      ),
                      Column(
                        children: [
                          Text('/month',
                              style: Theme.of(context).textTheme.bodyText1),
                          SizedBox(
                            height: 7,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: Text('Deposit Amount:\n ₹ ${widget.price}',
                      textAlign: TextAlign.end,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.bold, fontSize: 12)),
                ),
              ],
            ),
            // ],
            // ),m
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              height: 20,
              color: Colors.grey[300],
              child: Text(
                "How many months do you want to rent this for?",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: buildSliderTopLabel()),
            SizedBox(height: 10),
            Container(
              // height: 100,
              alignment: Alignment.topLeft,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('${widget.details}',
                  style: Theme.of(context).textTheme.headline3),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              height: 30,
              width: MediaQuery.of(context).size.width * 0.7,
              alignment: Alignment.center,
              child: Text("Delivery in 72 hours"),
              color: Colors.orange[300],
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
      bottomSheet: Container(
        color: Color(0Xfff2f2f2),
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    '₹$calculatedRent/month',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: "Montserrat"),
                  ),
                ),
                Container(
                  height: 20,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Text(
                    'Refundable Deposit ₹${widget.price}',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontFamily: "Montserrat"),
                  ),
                ),
              ],
            ),
            addToCart(context)
          ],
        ),
      ),
    );
  }
}
