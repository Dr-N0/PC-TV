import 'package:flutter/material.dart';
import 'package:pc_tv_phone/screens/App.dart';
import 'package:pc_tv_phone/screens/SignUp.dart';
import 'package:pc_tv_phone/screens/SignIn.dart';

void main() => runApp(PCTV());

class PCTV extends StatelessWidget {
  const PCTV({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PC TV',
      theme: ThemeData(
        primaryColor: const Color(0xFF6247AA),
        accentColor: const Color(0xFFA06CD5),
      ),
      home: App(),
    );
  }
}
