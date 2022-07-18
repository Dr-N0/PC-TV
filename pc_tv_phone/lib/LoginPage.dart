import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage(
      {super.key, required this.color, required this.title, this.onPush});
  final MaterialColor color;
  final String title;
  final ValueChanged<int>? onPush;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("This is Login Page"),
      ),
    );
  }
}
