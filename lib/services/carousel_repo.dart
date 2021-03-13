import 'package:http/http.dart' as http;
import 'package:rht/screens/splash_screen.dart';

class CarouselRepository {
  String _baseUrl = "$serverLink/api";
  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api);
  }
}
