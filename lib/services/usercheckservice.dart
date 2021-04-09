import '../screens/splash_screen.dart';
import 'package:dio/dio.dart';

class Usercheck {
  Dio dio = Dio();
  account(String userid, bool exist) async {
    final String pathUrl = "$serverLink/api/account";
    try {
      return await dio.post(pathUrl,
          data: {
            "id": userid,
            "exist": exist,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } catch (e) {
      print("in catch");
    }
  }
}
