import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:rht/models/collect.dart';
import '../../screens/admin/hprofit.dart';
import '../../screens/splash_screen.dart';
import 'package:flutter/material.dart';
class HighProfitBuild extends StatefulWidget {


  
 
  @override
  _HighProfitBuildState createState() => _HighProfitBuildState();
}

class _HighProfitBuildState extends State<HighProfitBuild> 
{
  Dio dio = new Dio();
    profitdata() async {
    final String pathUrl = "$serverLink/api/highprofit/$finalAdminLocationId";
    try {
      print('here22');
      
     // print();
      
      return await dio.get(pathUrl,
          
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
    }
  }

  var futurerest ;
  Future<List<Price>>convert() async{
    var res = await profitdata();
    print(res.data);
    
    print(res.data.runtimeType);
    //final Map parsed = json.decode(res.toString());
    //print (parsed);
         //var rest = Demand.fromJson(parsed);

          return (res.data as List)
          .map((x) => Price.fromJson(x))
          .toList();
  }

  void initState(){
    super.initState();

   futurerest= convert();
      
  }

@override
  Widget build(BuildContext context) {
    return SafeArea(
      // height: MediaQuery.of(context).size.h,
      child: FutureBuilder <List <Price>>(
          future: futurerest,
          // ignore: missing_return
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data == null) {
                return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          // title: Text('Reports '),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
                return BarDefault(snapshot.data);
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          centerTitle: true,
          // title: Text('Reports '),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
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
  }}