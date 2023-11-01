import 'package:flutter/material.dart';
import 'package:sem5demo3/bars/bargraapg.dart';

class Barhome extends StatefulWidget {
  const Barhome({Key? key}) : super(key: key);

  @override
  State<Barhome> createState() => _BarhomeState();
}

class _BarhomeState extends State<Barhome> {
  List<double> weeklySummary = [
    2,
    4,
    0,
    3,
    1,
    1,
    3,
  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SizedBox(
          height: 250,
          child: MyBargraph(
            weeklySummary: weeklySummary,
          ),
        ),
      )
    );
  }
}
