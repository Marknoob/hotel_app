import 'package:flutter/material.dart';
import 'package:hotel_app/pages/intropage.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   // backgroundColor: Colors.red,
        //   centerTitle: true,
        //   title: Text(
        //     "Hotelovers",
        //     style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        //           fontWeight: FontWeight.w900,
        //         ),
        //   ),
        // ),
        body: IntroPage(),
      ),
    );
  }
}
