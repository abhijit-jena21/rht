import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rht/models/currentorders.dart';
import 'package:rht/screens/splash_screen.dart';

class OrderService {
  Dio dio = new Dio();

  inTransitOrders(userid) async {
    final String pathUrl = "$serverLink/api/intransit";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Token': '$finalToken',
            'Admin': '$finalAdmin'
          }));
      // print(eturn.data.runtimeType);
      // return eturn;
    } catch (e) {
      print('here33');
    }
    print("here");
  }

  currentOrders(String userid) async {
    final String pathUrl = "$serverLink/api/currentorder";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Token': '$finalToken',
            'Admin': '$finalAdmin'
          }));
    } catch (e) {
      print('here33');
    }
    print("here");
  }

  cancelOrders(userid, productid, duration, from, date) async {
    final String pathUrl = "$serverLink/api/cancelorder";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
            "pid":productid,
            "from":from,
            "duration":duration,
            "date":date
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Token': '$finalToken',
            'Admin': '$finalAdmin'
          }));
    } catch (e) {
      print('here33');
    }
    print("here");
  }

  pastOrders(String userid) async {
    final String pathUrl = "$serverLink/api/pastorder";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
            'Token': '$finalToken',
            'Admin': '$finalAdmin'
          }));
    } catch (e) {
      print('here33');
    }
    print("here");
  }

  // ignore: missing_return
  Future<List<Currentorder>> getTransitOrders(userId) async {
    Response response = await inTransitOrders(userId);
    // print(response.runtimeType);
    // print(response.data);
    var res = json.decode(response.data); //String to List<dynamic>
    // var responseData = response.data;
    // print("responseData" + responseData);
    // print(responseData.runtimeType);
    // print(res.runtimeType);
    // print('some');
    // var test =
    return (res as List).map((x) => Currentorder.fromJson(x)).toList();
    // print("test" + test.toString());
  }

  // ignore: missing_return
  Future<List<Currentorder>> getCurrentOrders(userId) async {
    Response response = await currentOrders(userId);
    print(response.data);
    var res = json.decode(response.data);
    print('some');
    if (res != null)
      return (res as List)
          .map((x) => Currentorder.fromJson(x))
          .toList();
  }

  // ignore: missing_return
  Future<List<Currentorder>> getPastOrders(userId) async {
    Response response = await pastOrders(userId);
    print(response.data);
    var res = json.decode(response.data);
    print('some');
    if (res != null)
      return (res as List)
          .map((x) => Currentorder.fromJson(x))
          .toList();
  }
}
