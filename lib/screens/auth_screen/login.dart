import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preference/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  loginUserRequest() async {
    var data = {
      "email": emailController.text,
      "password": passwordController.text,
    };
    final response =
        await http.post(Uri.parse("https://reqres.in/api/login"), body: data);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome to Login Screen'.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(30),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(),
                  //     borderRadius: BorderRadius.all(Radius.circular(70),),),
                  hintText: 'info@email.com',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  prefix: Icon(
                    Icons.mail,
                  ),
                ),
              ),
              const Gap(40),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                obscuringCharacter: '*',
                decoration: const InputDecoration(
                  hintText: 'enter your password',
                  hintStyle: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  prefix: Icon(
                    Icons.lock,
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(MediaQuery.of(context).size.width, 50),
                    maximumSize: Size(MediaQuery.of(context).size.width, 50),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              const Gap(20),
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   decoration: ,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class LocalStorage {
  storeToken(String token) async {
    final storage = await SharedPreferences.getInstance();
    await storage.setString(
      "auth token",
      jsonEncode(token),
    );
  }

  logOut() async {
    final storage = await SharedPreferences.getInstance();
    await storage.remove('auth token');
  }
}
