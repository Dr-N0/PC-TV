import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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

    await _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Widget _square() {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.purple,
          textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          shape: const ContinuousRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
        ),
        onPressed: () {
          print(_scrollController.positions);
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
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          gridDelegate: SliverWovenGridDelegate.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            pattern: [
              WovenGridTile(1),
            ],
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
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
