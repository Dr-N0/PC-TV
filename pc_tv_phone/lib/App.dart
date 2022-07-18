import 'package:flutter/material.dart';
import 'package:pc_tv_phone/BottomNavigation.dart';
import 'package:pc_tv_phone/TabItem.dart';
import 'package:pc_tv_phone/TabNavigator.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var _currentTab = TabItem.red;
  final _navigatorKeys = {
    TabItem.red: GlobalKey<NavigatorState>(),
    TabItem.green: GlobalKey<NavigatorState>(),
    TabItem.blue: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.red) {
            // select 'main' tab
            _selectTab(TabItem.red);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.red),
          _buildOffstageNavigator(TabItem.green),
          _buildOffstageNavigator(TabItem.blue),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       gradient: LinearGradient(
  //         tileMode: TileMode.mirror,
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: <Color>[
  //           Color(0xFF6247AA),
  //           Color(0xFFA06CD5),
  //           Color(0xFFF67E7D)
  //         ],
  //         stops: [0.0, 0.4, 1],
  //       ),
  //     ),
  //     child: Scaffold(
  //       backgroundColor: Colors.transparent,
  //       body: _buildBody(),
  //       bottomNavigationBar: BottomNavigationBar(
  //         items: const <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.home),
  //             label: 'Home',
  //             backgroundColor: Colors.red,
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.change_circle),
  //             label: 'Change Computer',
  //             backgroundColor: Colors.green,
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.settings),
  //             label: 'Settings',
  //             backgroundColor: Colors.purple,
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.logout),
  //             label: 'Logout',
  //             backgroundColor: Colors.pink,
  //           ),
  //         ],
  //         currentIndex: _currentTab,
  //         selectedItemColor: Colors.black,
  //         onTap: (item) => _selectTab(context, item),
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBody() {
  //   return SafeArea(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: <Widget>[
  //         Container(
  //             color: TabHelper.color(TabItem.red),
  //             alignment: Alignment.center,
  //             child: FlatButton(
  //               child: Text(
  //                 'PUSH',
  //                 style: TextStyle(fontSize: 32.0, color: Colors.white),
  //               ),
  //               onPressed: _push,
  //             )),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}




// backgroundColor: const Color(0xFF6247AA),
// appBar: AppBar(
//   title: const Text('PC TV'),
//   backgroundColor: Colors.purple,
//   shape: const RoundedRectangleBorder(
//     borderRadius: BorderRadius.vertical(
//       bottom: Radius.circular(30),
//     ),
//   ),
//   actions: [
//     IconButton(
//       icon: const Icon(Icons.volume_up),
//       tooltip: 'Computer Sound Info',
//       onPressed: () {},
//     ),
//     IconButton(
//       icon: const Icon(Icons.battery_full),
//       tooltip: 'Battery Levels',
//       onPressed: () {},
//     ),
//     IconButton(
//       icon: const Icon(Icons.analytics),
//       tooltip: 'Computer Performance',
//       onPressed: () {},
//     ),
//     IconButton(
//       icon: const Icon(Icons.change_circle),
//       tooltip: 'Change Computer',
//       onPressed: () {},
//     ),
//     Theme(
//       data: Theme.of(context).copyWith(
//           dividerColor: Colors.black,
//           iconTheme: const IconThemeData(color: Colors.white)),
//       child: PopupMenuButton<int>(
//         color: Colors.white,
//         offset: Offset(0.0, appBarHeight + 10),
//         itemBuilder: (context) => [
//           const PopupMenuItem<int>(value: 0, child: Text("Settings")),
//           const PopupMenuItem<int>(
//               value: 1, child: Text("Privacy Policy page")),
//           const PopupMenuDivider(),
//           PopupMenuItem<int>(
//               value: 2,
//               child: Row(
//                 children: const [
//                   Icon(
//                     Icons.logout,
//                     color: Colors.red,
//                   ),
//                   SizedBox(
//                     width: 7,
//                   ),
//                   Text("Logout")
//                 ],
//               )),
//         ],
//         onSelected: (item) => selectedItem(context, item),
//       ),
//     ),
//   ],
//   elevation: 0.0,
// ),