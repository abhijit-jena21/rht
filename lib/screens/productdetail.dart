import 'package:flutter/material.dart';
import '../utils/sliderutil.dart';
import '../widgets/myslider.dart';
import '../widgets/carousel.dart';

class ProductDetail extends StatefulWidget {
  final String name;
  final List<String> img;
  final String details;
  final int price;
  final int rent;
  final int duration;
  // String imgPath,
  final List<String> items;
  ProductDetail(this.name, this.img, this.details, this.price, this.rent,
      this.duration, this.items);

  @override
  _ProductDetailState createState() => _ProductDetailState(this.rent);
}

class _ProductDetailState extends State<ProductDetail> {
  // int rent;
  _ProductDetailState(this.calculatedRent);
  MySlider mySlider;
  var indexTop = 0;
  var calculatedRent;
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
            inactiveColor: Theme.of(context).primaryColor,
            onChanged: (newRent) {
              print(newRent);
              setState(
                () {
                  this.indexTop = newRent.toInt();

                  if (indexTop == 0) {
                    calculatedRent = widget.rent;
                  } else if (indexTop == 1) {
                    calculatedRent = widget.rent - 8;
                  } else if (indexTop == 2) {
                    calculatedRent = widget.rent - 16;
                  } else if (indexTop == 3) {
                    calculatedRent = widget.rent - 24;
                  }
                },
              );
            } // label: labels[indexTop],
            ),
      ],
    );
  }

  Widget buildLabel({
    String label,
    // double width,
    // Color color,
  }) =>
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        // width: width,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline3,
        ),
      );

  @override
  Widget build(BuildContext context) {
    var images = [];
    // calculatedRent = widget.rent;
    widget.img.forEach((data) {
      images.add(NetworkImage(data));
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark, color: Color(0xFF545D68)),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: imageCarousel(images),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text('${widget.name}',
                        overflow: TextOverflow.clip,
                        style: Theme.of(context).textTheme.headline2)),
                Container(
                  // height: 50,
                  // width: double.infinity/2,
                  alignment: Alignment.centerRight,
                  width: MediaQuery.of(context).size.width * 0.4,
                  padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('₹ $calculatedRent',
                              style: Theme.of(context).textTheme.headline1),
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
                      Text('Deposit Amount:\n ₹ ${widget.price}',
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.headline3.copyWith(fontWeight: FontWeight.bold,fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
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
            Container(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.4,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Theme.of(context).accentColor,
                onPressed: null,
                child: Text(
                  'Add to Cart',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: "Montserrat"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
