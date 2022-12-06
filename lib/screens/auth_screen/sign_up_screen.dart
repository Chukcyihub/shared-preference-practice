import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preference/model/user.dart';
import 'package:shared_preference/provider/auth_provider.dart';
import 'package:shared_preference/provider/user_provider.dart';
import 'package:shared_preference/screens/auth_screen/login.dart';
import 'package:shared_preference/util/http_service.dart';

class Registration extends StatefulWidget {
  const Registration({super.key, required this.title});

  final String title;

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.green[300],
        centerTitle: true,
        title: Text(
          widget.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 30),
                  clipBehavior: Clip.none,
                  child: const Text(
                    "Registration",
                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                  keyboardType: TextInputType.name,
                  controller: name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Name cannot be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Name"),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: email,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Email cannot be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Email Address"),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: TextFormField(
                  obscureText: true,
                  obscuringCharacter: "*",
                  keyboardType: TextInputType.visiblePassword,
                  controller: password,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    label: Text("Password"),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(25),
                child: authProvider.registeredStatus == Status.registering
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            authProvider
                                .register(name.text, email.text, password.text)
                                .then((response) {
                              if (response['status'] == 500) {
                                HttpService()
                                    .showMessage(response['message'], context);
                              } else {
                                User user = User(
                                  user: response['data'].user,
                                  token: response['data'].token,
                                );
                                userProvider.setUser(user);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              }
                            });
                          }
                        },
                        child: const Text('Login'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
