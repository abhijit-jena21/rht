import 'package:dio/dio.dart';
import 'package:rht/screens/splash_screen.dart';

class PaymentService {
  Dio dio = new Dio();

  adminPayment(userid, pid, duration, date) async {
    final String pathUrl = "$serverLink/api/payment";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
            "pid": pid,
            "duration": duration,
            "date":date
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
      // print(eturn.data.runtimeType);
      // return eturn;
    } catch (e) {
      print('here33');
    }
  }

  userPayment(userid, pid, duration, date) async {
    final String pathUrl = "$serverLink/api/paymentstatus";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
            "pid": pid,
            "duration": duration,
            "date":date
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
      // print(eturn.data.runtimeType);
      // return eturn;
    } catch (e) {
      print('here33');
    }
  }
}
