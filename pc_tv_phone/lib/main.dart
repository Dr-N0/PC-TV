import 'package:flutter/material.dart';
import 'package:pc_tv_phone/LoginPage.dart';
import 'package:pc_tv_phone/SettingsPage.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PC TV',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var appBarHeight = AppBar().preferredSize.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF6247AA),
      appBar: AppBar(
        title: const Text('PC TV'),
        backgroundColor: Colors.purple,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.volume_up),
            tooltip: 'Computer Sound Info',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.battery_full),
            tooltip: 'Battery Levels',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.analytics),
            tooltip: 'Computer Performance',
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.change_circle),
            tooltip: 'Change Computer',
            onPressed: () {},
          ),
          Theme(
            data: Theme.of(context).copyWith(
                dividerColor: Colors.black,
                iconTheme: const IconThemeData(color: Colors.white)),
            child: PopupMenuButton<int>(
              color: Colors.white,
              offset: Offset(0.0, appBarHeight + 10),
              itemBuilder: (context) => [
                const PopupMenuItem<int>(value: 0, child: Text("Settings")),
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
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFF6247AA),
              Color(0xFFA06CD5),
              Color(0xFFF67E7D)
            ],
            stops: [0.0, 0.4, 1],
          ),
        ),
      ),
    );
  }

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
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false);
        break;
    }
  }
}
