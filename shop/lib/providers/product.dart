import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFav;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFav = false,
  });
  void _setFavValue(bool newValue) {
    isFav = newValue;
    notifyListeners();
  }

  void toggleFav(String token, String userId) async {
    final oldStatus = isFav;
    isFav = !isFav;
    notifyListeners();
    try {
      final url =
          'https://vue-http-e0103.firebaseio.com/userFav/$userId/$id.json?auth=$token';
      final response = await http.put(
        url,
        body: json.encode(isFav),
      );
      //firebase did not throw an error but we have to check status code
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      //in case of network error
      _setFavValue(oldStatus);
    }
  }
}
