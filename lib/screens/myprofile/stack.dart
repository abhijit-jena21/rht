import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:rht/models/userpayment.dart';
import 'package:rht/services/orderservice.dart';
import 'package:rht/services/paymentservice.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../screens/splash_screen.dart';
import '../../models/graph.dart';
import 'package:intl/intl.dart';

class Grab {
  String x;
  int y;
  Color colorval;
  Grab({this.x, this.y, this.colorval});
}

class Doughnut extends StatefulWidget {
  final Graph snapshot;
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

  Doughnut(
      this.snapshot,
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
  _DoughnutState createState() => _DoughnutState();
}

/// State class of doughnut chart.
class _DoughnutState extends State<Doughnut> {
  Dio dio = new Dio();
  PaymentService paymentService = PaymentService();
  var month;
  DateTime tempDate;
  OrderService _orderService = OrderService();
  void initState() {
    super.initState();
    // convert();
    // paymentstatus();
  }

  String parseDate(String date) {
    tempDate = new DateFormat("yyyy-MM-dd").parse(date);
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
    month = months[tempDate.month - 1];
    return "${tempDate.day} $month, ${tempDate.year}";
  }

  product() async {
    final String pathUrl = "$serverLink/api/userreport";
    try {
      print('here22');
      return await dio.post(pathUrl,
          data: {
            "_id": finalId,
            "index": 0,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } catch (e) {
      print('here33');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Product Summary',
            style: Theme.of(context).textTheme.headline6,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(17.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "${widget.snapshot.name}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.black87),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Monthly rent:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Deposit:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "₹${widget.rent}/unit",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "₹${widget.deposit} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Quantity:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Rented for:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${widget.count} ",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                          Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "${widget.duration} months",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Ordered on:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${parseDate(widget.checkoutDate)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //      child: Text("${widget.location} months",
                          //       style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.blue),)
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Last paid on:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Next payment date:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${parseDate(widget.snapshot.lastpaymentdate)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "${parseDate(widget.snapshot.nextpaymentdate)}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Due:",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(color: Colors.black87),
                              )),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "₹${widget.snapshot.due}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(color: Colors.blue),
                              )),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Savings Report",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.blue),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Total Price of Product(s): ₹${widget.snapshot.totalPrice}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.black87),
                      ),
                      userreport(context),
                      SizedBox(
                        height: 20,
                      ),
                      // ignore: deprecated_member_use
                      FlatButton(
                        color: Colors.red.shade600,
                        child: Text(
                          "Cancel Order",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: () {
                          _orderService.cancelOrders(
                              finalId,
                              widget.productId,
                              widget.duration,
                              "currentorder",
                              widget.checkoutDate);
                          widget.notifyParent(widget.index);
                          Navigator.pop(context);
                        },
                      )
                    ]),
              ),
            )));
  }

  /// Return the circular chart with default doughnut series.
  Widget userreport(BuildContext context) {
    return Container(
        child: Column(children: <Widget>[
      Container(
        child: SfCircularChart(
          annotations: <CircularChartAnnotation>[
            CircularChartAnnotation(
                height: '115%',
                width: '115%',
                widget: Container(
                    child: PhysicalModel(
                        child: Container(),
                        shape: BoxShape.circle,
                        elevation: 2,
                        shadowColor: Colors.black,
                        color: Colors.white.withOpacity(0.9)))),
            CircularChartAnnotation(
                widget: Container(
                    child: Text("Total Price:\n ₹${widget.snapshot.totalPrice}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 0.59),
                            fontSize: 15,
                            fontWeight: FontWeight.bold))))
          ],
          legend: Legend(
              textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
              isVisible: true,
              overflowMode: LegendItemOverflowMode.wrap,
              orientation: LegendItemOrientation.horizontal,
              position: LegendPosition.bottom),
          series: _getDefaultDoughnutSeries(),
          tooltipBehavior: TooltipBehavior(enable: true),
        ),
      ),
      SizedBox(height: 50),
      Container(
          child: SfCircularChart(
        annotations: <CircularChartAnnotation>[
          CircularChartAnnotation(
              height: '115%',
              width: '115%',
              widget: Container(
                  child: PhysicalModel(
                      child: Container(),
                      shape: BoxShape.circle,
                      elevation: 2,
                      shadowColor: Colors.black,
                      color: Colors.white.withOpacity(0.9)))),
          CircularChartAnnotation(
              widget: Container(
                  child: Text("Total Rent:\n ₹${widget.snapshot.totalRent}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 0.59),
                          fontSize: 15,
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold))))
        ],
        legend: Legend(
            textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            isVisible: true,
            overflowMode: LegendItemOverflowMode.wrap,
            orientation: LegendItemOrientation.horizontal,
            position: LegendPosition.bottom),
        series: _getDefaultDoughnutSeries2(),
        tooltipBehavior: TooltipBehavior(enable: true),
      )),
    ]));
  }

  /// Returns the doughnut series which need to be render.
  List<DoughnutSeries<Grab, String>> _getDefaultDoughnutSeries() {
    final List<Grab> chartData = <Grab>[
      Grab(
          x: 'Profit (in ₹)',
          y: widget.snapshot.profit,
          colorval: Colors.redAccent.shade400),
      Grab(
          x: 'Rent (in ₹)',
          y: widget.snapshot.totalRent,
          colorval: Colors.lightBlue[400]),
    ];
    return <DoughnutSeries<Grab, String>>[
      DoughnutSeries<Grab, String>(
        radius: '105%',
        // explode: true,
        explodeOffset: '10%',
        dataSource: chartData,
        xValueMapper: (Grab data, _) => data.x,
        yValueMapper: (Grab data, _) => data.y,
        pointColorMapper: (Grab data, _) => data.colorval,
        dataLabelSettings: DataLabelSettings(
            showZeroValue: false,
            isVisible: true,
            textStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
      )
    ];
  }
 
  List<DoughnutSeries<Grab, String>> _getDefaultDoughnutSeries2() {
    final List<Grab> chartData = <Grab>[
      Grab(
          x: 'Paid (in ₹)',
          y: widget.snapshot.paid,
          colorval: Colors.purple),
      Grab(x: 'Due (in ₹)', y: widget.snapshot.due, colorval: Colors.orange[700]),
      Grab(
          x: 'Payable (in ₹)',
          y: widget.snapshot.payable,
          colorval: Colors.yellow.shade700),
    ];
    return <DoughnutSeries<Grab, String>>[
      DoughnutSeries<Grab, String>(
          radius: '120%',
          // explode: true,
          explodeOffset: '10%',
          dataSource: chartData,
          xValueMapper: (Grab data, _) => data.x,
          yValueMapper: (Grab data, _) => data.y,
          pointColorMapper: (Grab data, _) => data.colorval,
          dataLabelSettings: DataLabelSettings(
              showZeroValue: false,
              isVisible: true,
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white, fontWeight: FontWeight.bold)))
    ];
  }
}
