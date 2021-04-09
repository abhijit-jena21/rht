import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:rht/models/pincode.dart';

class PostService {
  // Dio dio = new Dio();

  checkPin(pincode) async{
    var queryParameters = pincode;
    var endpointUrl = 'https://api.postalpincode.in/pincode/';
    // String queryString = Uri(queryParameters: queryParameters).query;
    var requestUrl = endpointUrl + queryParameters;
    print(requestUrl);
    // final String pathUrl = "https://api.postalpincode.in/pincode/{PINCODE}";
    try {
      return await http.get(requestUrl);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Couldn't fetch data",
          toastLength: Toast.LENGTH_SHORT,
          backgroundColor: Colors.grey.shade700,
          textColor: Colors.white,
          fontSize: 15.0);
    }
  }

  Future<Pincode> getPin(pincode) async {
    Response response = await checkPin(pincode);
    print(response.body);
    // var responseData = response.body;
    // print(data);
    var str = response.body.toString();
    print(str);
    var substr = str.substring(1, str.length - 1);
    print("substr: "+substr);
    final parsed = json.decode(substr);

    // return parsed.map((post)=>Pincode.fromJson(post)).toList()
    final res = Pincode.fromJson(parsed);
    print(res);
    // print('some');
    return res;
  }
}
