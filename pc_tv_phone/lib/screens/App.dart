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
  var appBarHeight = AppBar().preferredSize.height;

  void selectedItem(BuildContext context, item) {
    switch (item) {
      case 0:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const SettingsPage()));
        break;
      case 1:
        print("Privacy Clicked");
        break;
      case 2:
        print("User Logged out");
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => SignIn()), (route) => true);
        break;
    }
  }

  SizedBox _buildTopBarItem(IconData icon, String name) {
    return SizedBox.fromSize(
      size: Size(50, 50),
      child: ClipOval(
        child: Material(
          color: Color(0xFFF67E7D),
          child: InkWell(
            splashColor: Colors.green,
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(icon),
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
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        width: 3.0, color: Color.fromARGB(132, 32, 1, 22)),
                  ),
                  color: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTopBarItem(Icons.volume_up, 'Computer Sound Info'),
                    _buildTopBarItem(Icons.computer, 'Battery Levels'),
                    _buildTopBarItem(Icons.change_circle, 'Change Computer'),
                    Theme(
                      data: Theme.of(context).copyWith(
                          dividerColor: Colors.black,
                          iconTheme: const IconThemeData(color: Colors.white)),
                      child: PopupMenuButton<int>(
                        color: Colors.white,
                        offset: Offset(0.0, appBarHeight + 10),
                        itemBuilder: (context) => [
                          const PopupMenuItem<int>(
                              value: 0, child: Text("Settings")),
                          const PopupMenuItem<int>(
                              value: 1, child: Text("Privacy Policy page")),
                          const PopupMenuDivider(),
                          PopupMenuItem<int>(
                              value: 2,
                              child: Row(
                                children: const [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  Text("Logout")
                                ],
                              )),
                        ],
                        onSelected: (item) => selectedItem(context, item),
                      ),
                    ),
                  ],
                ),
              ),
              Flexible(child: InteractiveSquares()),
            ],
          ),
        ),
      ),
    );
  }
}
