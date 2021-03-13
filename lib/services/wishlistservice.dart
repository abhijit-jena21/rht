import 'package:dio/dio.dart';
import '../screens/splash_screen.dart';
import '../models/product.dart';

class WishlistService {
  Dio dio = new Dio();
  postToWishlist(finalId, productId, isFav) async {
    final String pathUrl = "$serverLink/api/wishlist";
    try {
      print('here22');
      // print(widget.userId);
      print(finalId);
      // print(widget.productId);
      return await dio.post(pathUrl,
          data: {
            "userid": finalId,
            "productid": productId,
            "status": !isFav,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
      // Fluttertoast.showToast(
      //     msg: e.response.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 15.0);
    }
  }

  Future<bool> responseFromWishlist(finalId, productId, isFav) async {
    Response response = await postToWishlist(finalId,productId,isFav);
    print(response.data);
    var responseData = response.data;
    return responseData;
  }

  userIdentity(String userid) async {
    // print(locationid);
    final String pathUrl = "$serverLink/api/wishlistproducts";
    try {
      print('here222');
      print(userid);
      return await dio.post(pathUrl,
          data: {
            "id": userid,
            // "sub": subcategoryid,
          },
          options: Options(headers: {
            'Content-type': 'application/json; charset=UTF-8',
          }));
    } on DioError catch (e) {
      print('here33');
      // Fluttertoast.showToast(
      //     msg: e.response.data['msg'],
      //     toastLength: Toast.LENGTH_SHORT,
      //     backgroundColor: Colors.red,
      //     textColor: Colors.white,
      //     fontSize: 15.0);
    }
    print("here");
  }

  // ignore: missing_return
  Future<List<Product>> getWishlistedProducts(userId) async {
    Response response = await userIdentity(userId);
    print(response.data);
    var responseData = response.data;
    // print(data);
    print('some');
    if (responseData != null)
      return (responseData as List).map((x) => Product.fromJson(x)).toList();
  }
}
