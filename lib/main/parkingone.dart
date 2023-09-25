import 'package:flutter/material.dart';

class MainParkingPage extends StatefulWidget {
  const MainParkingPage({Key? key}) : super(key: key);

  @override
  State<MainParkingPage> createState() => _MainParkingPageState();
}

class _MainParkingPageState extends State<MainParkingPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("MainParking Page"),

      ),
    );
  }
}
