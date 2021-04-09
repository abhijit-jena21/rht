import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/collect.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BarlowDefault extends StatefulWidget {
 List <Price> snapshot;
BarlowDefault(this.snapshot); 

  @override
  _BarlowDefaultState createState() => _BarlowDefaultState();
}


class _BarlowDefaultState extends State<BarlowDefault> {

  double _xLabelsExtent = 80;
  bool _isEnableLabelExtend = false;

@override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            
            centerTitle: true,
            // title: Text('Reports '),
            leading:IconButton(icon: Icon(Icons.arrow_back, color: Colors.black87,),
        onPressed: () {Navigator.of(context).pop();
                        },),
          ),
          body: Padding(
                padding: EdgeInsets.all(17.0),
                child: Container(
                  child: Center(
    child:_buildDefaultBarChart(),
    
    ),) 
    ) );
  }
  


  SfCartesianChart _buildDefaultBarChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text:'Top 10 Least Profitable Products'),
      legend: Legend(isVisible:true),
      primaryXAxis: CategoryAxis(
        arrangeByIndex: true,
         labelsExtent: _isEnableLabelExtend ? _xLabelsExtent : null,
          // title: AxisTitle(text:''),
          maximumLabelWidth: 80,
        majorGridLines: MajorGridLines(width: 0),
        title: AxisTitle(text:''),
          // minimum: 0,
      ),
      primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
          numberFormat: NumberFormat.compact()),
      series: _getDefaultBarSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  /// Returns the list of chart series which need to render on the barchart.
  List<BarSeries<SampleData, String>> _getDefaultBarSeries() {
    final List<SampleData> chartData = <SampleData>[
      for(int i=0;i<widget.snapshot.length ;i++)
      SampleData(
          x: widget.snapshot[i].name,
          y: widget.snapshot[i].price,
          z: widget.snapshot[i].collected,
          ),
      
      
    ];
    return <BarSeries<SampleData, String>>[
      BarSeries<SampleData, String>(
          dataSource: chartData,
          xValueMapper: (SampleData sales, _) => sales.x,
          yValueMapper: (SampleData sales, _) => sales.y,
          color: Colors.redAccent.shade200,
          dataLabelSettings:
              DataLabelSettings(isVisible: true, offset: Offset(-5, 0)),
          name: 'Price (in ₹)'),
      BarSeries<SampleData, String>(
          dataSource: chartData,
          xValueMapper: (SampleData sales, _) => "",
          yValueMapper: (SampleData sales, _) => sales.z,
          color: Colors.lightBlue,
          dataLabelSettings:
              DataLabelSettings(isVisible: true, offset: Offset(-5, 0)),
          name: 'Collected (in ₹)'),
      
    ];
  }
}

class SampleData{
String x;
int y;
int z;
SampleData({this.x, this.y,this.z});

}