import 'package:http/http.dart' as http;

class CarouselRepository {
  String _baseUrl = "https://ecom-api.lutforrahman.com/api";
  httpGet(String api) async {
    return await http.get(_baseUrl + "/" + api);
  }
}
