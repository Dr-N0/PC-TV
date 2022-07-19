import 'package:flutter/material.dart';

class InteractiveSquares extends StatefulWidget {
  const InteractiveSquares({Key? key}) : super(key: key);

  @override
  State<InteractiveSquares> createState() => _InteractiveSquaresState();
}

class _InteractiveSquaresState extends State<InteractiveSquares> {
  List<Widget> _squareList = [];

  void _addCustomSquare() {
    setState(() {
      _squareList.add(_square());
    });
  }

  Widget _square() {
    return Container(
      padding: const EdgeInsets.all(40),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: const ContinuousRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        onPressed: () {},
        child: Text('Click'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: _squareList.length,
            itemBuilder: (BuildContext ctx, index) {
              return _squareList[index];
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomSquare,
        tooltip: 'Add',
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
