import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rht/models/cartproduct.dart';
import 'package:rht/screens/splash_screen.dart';

class CartService {
  Dio dio = new Dio();
  addToCart(finalId, productId, locationId, name, count, duration, rent, image,
      date, deposit) async {
    final String pathUrl = "$serverLink/api/cartfirsttime";
    try {
      print('here22');
      // print(widget.userId);
      print(finalId);
      // print(widget.productId);
      return await dio.post(pathUrl,
          data: {
            "userid": finalId,
            "product": {
              "p_id": productId,
              "locationid": locationId,
              "name": name,
              "count": count,
              "duration": duration,
              "_rent": rent,
              "img": image,
              "checkoutdate": date,
              "deposit": deposit
            }
          },
          options: Options(
            headers: {
              'Content-type': 'application/json; charset=UTF-8',
            },
          ));
    } on DioError catch (e) {
      print('here33');
    }
  }

  userIdentity(String userid) async {
    // print(locationid);
    final String pathUrl = "$serverLink/api/cartproducts";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
    }
    print("here");
  }

  Future<List<CartProduct>> getCartProducts(userId) async {
    Response response = await userIdentity(userId);
    print(response.data);
    var responseData = response.data;
    // print(data);
    print('some');
    if (responseData != null)
      return (responseData as List)
          .map((x) => CartProduct.fromJson(x))
          .toList();
  }

  deleteFromCart(userid, pId, count, duration) async {
    final String pathUrl = "$serverLink/api/removecartproduct";
    try {
      print('here22');
      // print(widget.userId);
      // print(finalId);
      // print(widget.productId);
      return await dio.post(pathUrl,
          data: {
            "userid": userid,
            "p_id": pId,
            "count": count,
            "duration": duration,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
      // ignore: unused_catch_clause
    } on DioError catch (e) {
      print('here33');
    }
  }

  getStock(productId) async {
    final String pathUrl = "$serverLink/api/stock";
    try {
      print('here22');
      // print(widget.userId);
      // print(finalId);
      // print(widget.productId);
      return await dio.post(pathUrl,
          data: {
            "_id": productId,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
    }
  }

  checkStock(userid) async{
    final String pathUrl = "$serverLink/api/stockcheck";
    try {
      print('here22');
      return await dio.post(pathUrl,
          data: {
            "id": userid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
    }
  }

  Future<String> respondStock(userid) async {
    Response response = await checkStock(userid);
    // print(response.data);
    var responseData = json.decode(response.data);

    return responseData;
  }

  cartUpdate(
      userId, value, status, pId, duration, count, _rent, deposit) async {
    final String pathUrl = "$serverLink/api/cartupdate";
    try {
      print("here22");
      print(count);
      return await dio.post(pathUrl,
          data: {
            "userid": userId,
            "value": value,
            "status": status,
            "product": {
              "p_id": pId,
              "duration": duration,
              "count": count,
              "_rent": _rent,
              "deposit": 1000
            }
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print("here33");
    }
  }

  countChange(
      userId, value, status, pId, duration, count, _rent, deposit) async {
    Response response = await cartUpdate(
        userId, value, status, pId, duration, count, _rent, deposit);
    print(response.data);
    var responseData = response.data;
    // print(data);
    print('some');
    // if (responseData != null)
    //   return (responseData as List)
    //       .map((x) => CartProduct.fromJson(x))
    //       .toList();
  }
}
