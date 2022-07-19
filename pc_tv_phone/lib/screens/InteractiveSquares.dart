import 'package:flutter/material.dart';

class InteractiveSquares extends StatefulWidget {
  const InteractiveSquares({Key? key}) : super(key: key);

  @override
  State<InteractiveSquares> createState() => _InteractiveSquaresState();
}

class _InteractiveSquaresState extends State<InteractiveSquares> {
  final List<Widget> _squareList = <Widget>[];
  final ScrollController _scrollController = ScrollController();

  void _addCustomSquare() async {
    setState(() {
      _squareList.add(_square());
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _square() {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: const Color.fromARGB(207, 155, 39, 176),
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: const ContinuousRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        onPressed: () {
          print('square tapped');
        },
        child: Text('Click'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: GridView.builder(
          primary: false,
          padding: const EdgeInsets.all(30),
          controller: _scrollController,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: _squareList.length,
          itemBuilder: (BuildContext ctx, index) {
            return _squareList[index];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCustomSquare,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
