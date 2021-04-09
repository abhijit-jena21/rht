import 'package:dio/dio.dart';
import 'dart:convert';
import '../../models/plot.dart';
import '../../models/graph.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Lowgraph extends StatefulWidget {
 List <Demand > snapshot;
Lowgraph(this.snapshot);
  
  @override
  _LowgraphState createState() => _LowgraphState();
}
List <Demand> chartData =[];
class _LowgraphState extends State<Lowgraph> {
  
  double _xMaximumLabelWidth = 80;
  double _xLabelsExtent = 80;
  bool _isEnableLabelExtend = false;
  
  bool _isEnableMaximumLabelWidth = true;
  
  List<bool> _isSelected;
  String _selectedType = 'Maximum label width';
  
  final List<String> _typeList = <String>[
    'Maximum label width',
    'Labels extent'
  ];
  TooltipBehavior _tooltipBehavior;

  void initState(){
    super.initState();

    chartData = widget.snapshot;
      
  }

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
                child: SingleChildScrollView(
                    child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
    child:_buildmaximumLabelWidthChart(),
    
    ),),
                )
    ) );
  }
  

  

  /// Returns the Cartesian chart with sorting options.
  SfCartesianChart _buildmaximumLabelWidthChart() {
    return SfCartesianChart(
      title: ChartTitle(text:  "Top 10\nLow Demand Products"),
      
      plotAreaBorderWidth: 0,
      
      primaryXAxis: CategoryAxis(
        arrangeByIndex: true,
          labelsExtent: _isEnableLabelExtend ? _xLabelsExtent : null,
          // title: AxisTitle(text:''),
          maximumLabelWidth: _xMaximumLabelWidth,
          majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: NumericAxis(
          title: AxisTitle(text:'Number of times rented'),
          minimum: 0,
          maximum: 10,
          
          majorTickLines: MajorTickLines(size: 0)),
      series: _getDefaultSortingSeries(),
      tooltipBehavior: _tooltipBehavior,
    );
  }

  
    List<CartesianSeries<SampleData, String>> _getDefaultSortingSeries() {
    final List<SampleData> chartData = <SampleData>[
      for(int i=0;i<widget.snapshot.length ;i++)
      
      SampleData(x: widget.snapshot[i].name, y: widget.snapshot[i].demand)
      ];
      return <BarSeries<SampleData ,String>>
      [
        BarSeries<SampleData, String>(
          dataSource: chartData,
          xValueMapper: (SampleData data, _) => data.x,
          yValueMapper: (SampleData data, _) => data.y,
          color: Colors.blue,
          dataLabelSettings: DataLabelSettings(isVisible: true, offset: Offset(-5,0)),
        )
      ];
    }
    
    


}

class SampleData{
String x;
int y;
SampleData({this.x, this.y});

}
