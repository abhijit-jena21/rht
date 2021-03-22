import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class PiePage extends StatefulWidget {
  final Widget child;

  PiePage({Key key, this.child}) : super(key: key);

  _PiePageState createState() => _PiePageState();
}

class _PiePageState extends State<PiePage> {
  
  List<charts.Series<Circle, String>> _seriesPieData;
  

  _generateData() {
    

    var piedata = [
      new Circle('AC', 35.8, Color(0xffe74c3c )),
      new Circle('Fridge', 8.3, Color(0xffe67e22 )),
      new Circle('Computer', 10.8, Color(0xfff5b041 )),
      new Circle('TV', 15.6, Color(0xfff4d03f )),
      new Circle('Dumbell', 19.2, Color(0xffedbb99 )),
      new Circle('Phone', 10.3, Color(0xfff6ddcc )),
    ];

    
    

    _seriesPieData.add(
      charts.Series(
        domainFn: (Circle name, _) => name.name,
        measureFn: (Circle name, _) => name.profit,
        colorFn: (Circle name, _) =>
            charts.ColorUtil.fromDartColor(name.colorval),
        id: 'RHT',
        data: piedata,
         labelAccessorFn: (Circle row, _) => '${row.profit}',
      ),
    );

    
  }

  @override
  void initState() {
    
    super.initState();
    
    _seriesPieData = List<charts.Series<Circle, String>>();
    
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFFFA751),
            
            bottom: TabBar(
              indicatorColor: Colors.blueAccent,
              tabs: [
                Tab(
                  icon: Icon(Icons.bar_chart_rounded),
                ),
                Tab(icon: Icon(Icons.pie_chart_outline_rounded)),
                Tab(icon: Icon(Icons.linear_scale_rounded),
                )],
            ),
            centerTitle: true,
            title: Text('Reports'),
            leading:IconButton(icon: Icon(Icons.arrow_back_ios_rounded),
        onPressed: () {Navigator.of(context).pop();
                        },),
          ),
          body: TabBarView(
            children: [
              /*Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Profit Incurred by renting products',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            
                            animationDuration: Duration(seconds: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Profit Incurred on RHT ',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart(
                            _seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                             behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                           defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                             arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Profit of various products',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.LineChart(
                            _seriesLineData,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: true, stacked: true),
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                            behaviors: [
        new charts.ChartTitle('Profit',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Months',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Products',
            behaviorPosition: charts.BehaviorPosition.end,
            titleOutsideJustification:charts.OutsideJustification.middleDrawArea,
            )   
      ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}



class Circle {
  String name;
  double profit;
  Color colorval;

  Circle(this.name, this.profit, this.colorval);
}

