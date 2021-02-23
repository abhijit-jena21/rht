import 'package:http/http.dart' as http;

class CarouselRepository {
  String _baseUrl = "http://10.0.3.2:8080/api";
  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api);
  }
}
