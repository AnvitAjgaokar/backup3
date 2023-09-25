import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPageOne extends StatefulWidget {
  const LoadingPageOne({Key? key}) : super(key: key);

  @override
  State<LoadingPageOne> createState() => _LoadingPageOneState();
}

class _LoadingPageOneState extends State<LoadingPageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset("assets/animations/mapani.json"),
      ),
    );
  }
}
