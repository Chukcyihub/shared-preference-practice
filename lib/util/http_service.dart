import 'package:flutter/material.dart';

class HttpService {
  static const String baseUrl = "https://emmi-softwaretrack.online/api/";
  static const String register = "${baseUrl}register";
  static const String login = "${baseUrl}login";

  void showMessage(String message, BuildContext context) {
    var snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
