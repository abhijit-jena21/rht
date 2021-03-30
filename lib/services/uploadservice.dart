import 'package:dio/dio.dart';
import '../screens/splash_screen.dart';

class UploadService {
  Dio dio = new Dio();
  addProduct(name, subcategoryId, categoryName, subcategoryName, price, rent,
      deposit, quantity, details, List image, indices) async {
    final String pathUrl = "$serverLink/api/values";
    Map<String, dynamic> formData = {
      "name": name,
      "price": price,
      "details": details,
      "rent": rent,
      "deposit": deposit,
      "stock": quantity,
      "subcategoryid": subcategoryId,
      "catname": categoryName,
      "subname": subcategoryName,
      "locationid": finalAdminLocationId,
      "indices": indices,
      "from":"creation"
    };
    Map<String, MultipartFile> fileMap = {};
    for (var i = 0; i < image.length; i++) {
      var time = DateTime.now();
      var timeString = time.toString();
      fileMap["img${i + 1}"] = await MultipartFile.fromFile(
          image.elementAt(i).path,
          filename: "${name.trim()}$i-$timeString");
    }
    formData.addAll(fileMap);
    try {
      print('here22');
      await dio.post(pathUrl, data: FormData.fromMap(formData));
    } catch (e) {
      print('here33');
    }
  }

   editProduct(productId, name, details, price, rent,
      deposit, List image, String indices) async {
    final String pathUrl = "$serverLink/api/adminupdate";
    Map<String, dynamic> formData = {
      "name": name,
      "price": price,
      "details": details,
      "rent": rent,
      "deposit": deposit,
      "id":productId,
      "indices":indices,
      "from":"updation"
    };
    Map<String, MultipartFile> fileMap = {};
    for (var i = 0; i < image.length; i++) {
      var time = DateTime.now();
      var timeString = time.toString();
      fileMap["img${i+1}"] = await MultipartFile.fromFile(
          image.elementAt(i).path,
          filename: "${name.trim()}$i-$timeString");
    }
    formData.addAll(fileMap);
    try {
      print('here22');
      await dio.post(pathUrl, data: FormData.fromMap(formData));
    } catch (e) {
      print('here33');
    }
  }

  delete(productId) async {
    final String pathUrl = "$serverLink/api/delete";
    try {
      print('here22');
      return await dio.post(pathUrl,
          data: {
            "productid": productId,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
      // ignore: unused_catch_clause
    } on DioError catch (e) {
      print('here33');
    }
  }

  updateStock(productId, quantity) async {
    final String pathUrl = "$serverLink/api/adminstock";
    try {
      print('here22');
      return await dio.post(pathUrl,
          data: {"productid": productId, "quantity": quantity},
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
      // ignore: unused_catch_clause
    } on DioError catch (e) {
      print('here33');
    }
  }
}
