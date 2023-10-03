import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sem5demo3/main/saved.dart';

class SavedLoadingPageOne extends StatefulWidget {
  const SavedLoadingPageOne({Key? key}) : super(key: key);

  @override
  State<SavedLoadingPageOne> createState() => _SavedLoadingPageOneState();
}

class _SavedLoadingPageOneState extends State<SavedLoadingPageOne> {
  @override
  void initState() {
    super.initState();

    // Introduce a delay of 2 seconds before navigating to the next page
    Future.delayed(Duration(seconds: 2), () {
      // Use Navigator to navigate to the next page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => MainSavePage(), // Replace 'NextPage' with your desired destination page
        ),
      );
    });
  }

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