import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Welcome to Home Screen!",
                style: TextStyle(
                  color: Color(0xff000000),
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Gap(20),
              ElevatedButton(onPressed: () {}, child: const Text('Logout')),
            ],
          ),
        ),
      ),
    );
  }
}
