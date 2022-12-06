import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preference/provider/auth_provider.dart';
import 'package:shared_preference/provider/user_provider.dart';
import 'package:shared_preference/screens/auth_screen/sign_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const Registration(title: ''),
      ),
    );
  }
}
