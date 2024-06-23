import 'package:flutter/material.dart';
import 'package:hotel_app/widgets/discoverypage.dart';
import 'package:hotel_app/widgets/historypage.dart';
import 'package:hotel_app/widgets/homepage.dart';
import 'package:hotel_app/widgets/model.dart';
import 'package:hotel_app/widgets/profilepage.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int pilihanMenu = 0;
  final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const DiscoveryPage(),
    const HistoryPage(),
    const ProfilePage(),
    const ModelPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _widgetOptions.elementAt(pilihanMenu),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Discovery",
              icon: Icon(Icons.search_outlined),
            ),
            BottomNavigationBarItem(
              label: "History",
              icon: Icon(Icons.history_rounded),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(Icons.person_2_outlined),
            ),
            // BottomNavigationBarItem(
            //   label: "Model",
            //   icon: Icon(Icons.book),
            // ),
          ],
          currentIndex: pilihanMenu,
          onTap: (int index) {
            setState(() {
              pilihanMenu = index;
            });
          },
        ),
      ),
    );
  }
}
