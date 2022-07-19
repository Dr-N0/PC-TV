import 'package:flutter/material.dart';
import 'package:pc_tv_phone/screens/InteractiveSquares.dart';
import 'package:pc_tv_phone/screens/SignIn.dart';
import 'package:pc_tv_phone/screens/SettingsPage.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var appBarHeight = AppBar().preferredSize.height + 10;

  void test() {
    print("Privacy Clicked");
  }

  SizedBox _buildTopBarItem(IconData icon, String name, clicked) {
    return SizedBox.fromSize(
      size: const Size(50, 50),
      child: ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: const Color(0xFFF67E7D),
            onTap: () {
              clicked();
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color: const Color(0xFFF67E7D),
                  size: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6247AA),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              tileMode: TileMode.mirror,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Color(0xFFA06CD5),
                Color(0xFF6247AA),
              ],
              stops: [0.0, 0.5],
            ),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTopBarItem(
                        Icons.volume_up, 'Computer Sound Info', test),
                    _buildTopBarItem(Icons.computer, 'Battery Levels', test),
                    _buildTopBarItem(
                        Icons.change_circle, 'Change Computer', test),
                    _buildTopBarItem(Icons.logout, 'Log out', test),
                  ],
                ),
              ),
              // TODO:
              // Button turns into popup dialog for custom button
              Flexible(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const Center(
                    child: InteractiveSquares(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
