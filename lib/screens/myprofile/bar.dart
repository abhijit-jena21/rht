import 'package:flutter/material.dart';
import 'package:rht/screens/splash_screen.dart';
import 'package:rht/services/orderservice.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../models/graph.dart';
import "package:intl/intl.dart";

class Bar extends StatefulWidget {
  final UserGraph snapshot;
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

  Bar(
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
  _BarState createState() => _BarState();
}

class _BarState extends State<Bar> {
  var month;
  DateTime tempDate;
  OrderService _orderService = OrderService();
  void initState() {
    super.initState();
    // convert();
    parseDate();
  }

  void parseDate() {
    tempDate = new DateFormat("yyyy-MM-dd").parse(widget.checkoutDate);
    // deliveryDate = tempDate.add(Duration(days: 30));
    print(widget.checkoutDate);

    // print(DateTime.now());
    // print(deliveryDate.month);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          centerTitle: true,
          title: Text(
            'Product Summary',
            style: Theme.of(context).textTheme.bodyText1,
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
                            "${widget.snapshot.x}",
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
                                "${tempDate.day} $month, ${tempDate.year} ",
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
                        "Total Price of Product(s): ₹${widget.snapshot.total}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: Colors.black87),
                      ),
                      _getBar(),
                      SizedBox(
                        height: 20,
                      ),
                      FlatButton(
                        color: Colors.red.shade600,
                        child: Text(
                          "Cancel Order",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        onPressed: () {
                          _orderService.cancelOrders(finalId, widget.productId,
                              widget.duration, "currentorder");
                          widget.notifyParent(widget.index);
                          Navigator.pop(context);
                        },
                      )
                    ]),
              ),
            )));
  }

  SfCartesianChart _getBar() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      legend: Legend(isVisible: true),

      //borderColor: Color.fromRGBO(198, 201, 207, 1) ,

      //title: ChartTitle(text: 'Reports of your Rented Product'),
      primaryXAxis: CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: widget.snapshot.total.toDouble(),
          axisLine: AxisLine(width: 1),
          majorGridLines: MajorGridLines(width: 1),
          title: AxisTitle(
              text: 'Profit earned',
              textStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.black87)),
          majorTickLines: MajorTickLines(size: 1)),
      series: _getBarSeries(),
      tooltipBehavior: TooltipBehavior(
          enable: true,
          header: '',
          canShowMarker: false,
          format: 'point.y in point.x'),
    );
  }

  List<ColumnSeries<UserGraph, String>> _getBarSeries() {
    final List<UserGraph> chartData = <UserGraph>[
      UserGraph(x: widget.snapshot.x, y: widget.snapshot.y),
    ];
    return <ColumnSeries<UserGraph, String>>[
      ColumnSeries<UserGraph, String>(
        dataSource: chartData,
        borderRadius: BorderRadius.circular(1),
        trackColor: const Color.fromRGBO(198, 201, 207, 1),
        isTrackVisible: true,
        dataLabelSettings: DataLabelSettings(
            isVisible: true, labelAlignment: ChartDataLabelAlignment.top),
        xValueMapper: (UserGraph product, _) => product.x,
        yValueMapper: (UserGraph product, _) => product.y,
        name: 'Profit',
      ),
    ];
  }
}
