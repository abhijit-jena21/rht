// import 'dart:html';

import 'package:dio/dio.dart';
import '../screens/splash_screen.dart';

class UploadService {
  Dio dio = new Dio();
  addProduct(
      name, subcategoryId, price, rent, deposit, quantity, details, List image) async {
    final String pathUrl = "$serverLink/api/values";
    FormData formData = FormData.fromMap({
      "name":name,
      "price": price,
      "details":details,
      "rent": rent,
      "deposit":deposit,
      "stock": quantity,
      "subcategoryid" : subcategoryId,
      "locationid": finalAdminLocationId,
      "img1":image.elementAt(0),
      "img2":image.elementAt(1),
      "img3":image.elementAt(2)
    });
    try {
      print('here22');
      // print(widget.userId);
      // print(finalId);
      // print(widget.productId);
      return await dio.post(pathUrl,
          data: formData,
          options: Options(
            headers: {
              'Content-type': 'multipart/form-data',
            },
          ));
    } catch (e) {
      print('here33');
    }
  }
}
