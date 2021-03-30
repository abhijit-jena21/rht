import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rht/models/product.dart';
import '../screens/splash_screen.dart';

class ProductDetailsService {
  Dio dio = new Dio();
  post(productId) async {
    final String pathUrl = "$serverLink/api/productdetails";
    try {
      print('here22');
      // print(widget.userId);
      // print(finalId);
      // print(widget.productId);
      return await dio.post(pathUrl,
          data: {
            "id": productId,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
      Fluttertoast.showToast(
          msg: e.response.data['msg'],
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<Product> response(productId) async {
    Response response = await post(productId);
    // print(response.data);
    var responseData = response.data;
    return Product.fromJson(responseData);
  }
}
