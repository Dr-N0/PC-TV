import 'package:flutter/material.dart';

void main() {
  runApp(const InteractiveSquares());
}

class InteractiveSquares extends StatelessWidget {
  const InteractiveSquares({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GridView.count(
        primary: true,
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }),
      ),
    );
  }
}
