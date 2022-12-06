import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preference/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter your login details!',
                style: TextStyle(
                  color: Color(0xff000000),
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(30),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 5, bottom: 5),
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    hintText: 'info@email.com',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    prefix: Icon(
                      Icons.mail,
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, top: 5, bottom: 5, right: 10),
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  obscuringCharacter: '*',
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    hintText: 'enter your password',
                    hintStyle: TextStyle(
                      fontStyle: FontStyle.italic,
                    ),
                    prefix: Icon(
                      Icons.lock,
                    ),
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
