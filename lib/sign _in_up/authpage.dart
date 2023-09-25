import 'package:flutter/material.dart';
import 'package:sem5demo3/sign%20_in_up/newsignup.dart';
import 'package:sem5demo3/sign%20_in_up/signin.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showSiginPage = true;
  @override
  Widget build(BuildContext context) {
    if (showSiginPage) {
      return LoginPage();
    }
    else {
      return SignUpPage();
    }


  }
}
