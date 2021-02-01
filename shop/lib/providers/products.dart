import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/http_exception.dart';

import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  final String authToken;
  final String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    //we have to create new array because if the pointer is the old pointer
    //so the builder will not rebuild the widget because the data did not change
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((el) => el.isFav).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((el) => el.id == id);
  }

  Future<void> fetchProducts([bool filterByUser = false]) async {
    print('filter is $filterByUser');
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$userId"' : '';
    String url =
        'https://vue-http-e0103.firebaseio.com/products.json?auth=$authToken&$filterString';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) return;
      url =
          'https://vue-http-e0103.firebaseio.com/userFav/$userId.json?auth=$authToken';
      final favRes = await http.get(url);
      final favData = json.decode(favRes.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((productId, product) {
        loadedProducts.add(Product(
          id: productId,
          title: product['title'],
          description: product['description'],
          price: product['price'],
          imageUrl: product['imageUrl'],
          isFav: favData == null ? false : favData['$productId'] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://vue-http-e0103.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'creatorId': userId,
          },
        ),
      );
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );

      _items.add(newProduct);
      //we call this method to tell other widget that listen to this provider
      //to rebuild the widget tree
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product product) async {
    try {
      final index = _items.indexWhere((el) => el.id == id);
      if (index < 0) return;
      final url =
          'https://vue-http-e0103.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'price': product.price,
            'imageUrl': product.imageUrl,
          },
        ),
      );
      _items[index] = product;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  void deleteProduct(String id) async {
    final url =
        'https://vue-http-e0103.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProductIndex = _items.indexWhere((el) => el.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      //Optimitic delete (Roll back the delete operation)
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    }
    existingProduct = null;
  }
}
