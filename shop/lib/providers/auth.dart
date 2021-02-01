import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expityDate;
  String _userId;

  bool get isAuth {
    return token != null;
  }

  String get token {
    if (_expityDate != null &&
        _expityDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url =
        'https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyDi9knI5t776wN2jQ1B6Nx9-6sycYqeW2I';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final res = json.decode(response.body);
      if (res['error'] != null) {
        throw HttpException(res['error']['message']);
      }
      _token = res['idToken'];
      _userId = res['localId'];
      _expityDate =
          DateTime.now().add(Duration(seconds: int.parse(res['expiresIn'])));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signUp');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'signInWithPassword');
  }
}
