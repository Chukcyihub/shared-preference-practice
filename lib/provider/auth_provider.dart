import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preference/model/user.dart';
import 'package:shared_preference/preference/user_preference.dart';
import 'package:shared_preference/util/http_service.dart';

enum Status {
  notRegistered,
  registering,
  registered,
  notLoggedIn,
  loggingIn,
  loggedIn,
}

class AuthProvider with ChangeNotifier {
  Status _registeredStatus = Status.notRegistered;
  Status _loggingStatus = Status.notLoggedIn;
  Status get registeredStatus => _registeredStatus;
  Status get loggingStatus => _loggingStatus;
  set registeredStatus(Status value) {
    registeredStatus = value;
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> loginBody = {
      "email": email,
      "password": password,
    };
    _loggingStatus = Status.loggingIn;
    notifyListeners();
    var response = await post(Uri.parse(HttpService.login),
            body: json.encode(loginBody),
            headers: {'content-Type': 'application/json'})
        .then(onValue)
        .catchError(onError);
    _loggingStatus = Status.loggedIn;
    notifyListeners();
    return response;
  }

  Future<Map<String, dynamic>> register(
      String name, String email, String password) async {
    final Map<String, dynamic> registeredData = {
      "name": name,
      "email": email,
      "password": password,
    };
    _registeredStatus = Status.registering;
    notifyListeners();
    var response = await post(Uri.parse(HttpService.register),
            body: json.encode(registeredData),
            headers: {'content-Type': "application/json"})
        .then(onValue)
        .catchError(onError);

    _registeredStatus = Status.registered;
    notifyListeners();

    return response;
  }

  static Future onValue(Response response) async {
    Map<String, dynamic> result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      if (responseData.containsKey('validation_errors')) {
        result = {
          'status': 500,
          'message': responseData['validation_errors'].toString(),
          'data': null,
        };
      } else {
        var userData = responseData;
        User user = User.fromJson(userData);
        UserPreference().saveRegisteredUser(user);

        result = {
          "status": 200,
          "message": responseData["message"],
          "data": user
        };
      }
      return result;
    }
  }

  static onError(error) {
    return {
      'status': false,
      'message': "unexpected Error Encountered",
      'data': error
    };
  }
}
