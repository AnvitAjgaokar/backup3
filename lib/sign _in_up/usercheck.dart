import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sem5demo3/main/mainhompage.dart';
import 'package:sem5demo3/main/mainpage.dart';
import 'package:sem5demo3/sign%20_in_up/authpage.dart';
import 'package:sem5demo3/sign%20_in_up/signin.dart';

class UserCheck extends StatefulWidget {
  const UserCheck({Key? key}) : super(key: key);

  @override
  State<UserCheck> createState() => _UserCheckState();
}

class _UserCheckState extends State<UserCheck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges() ,
          builder: (context,snapshot){
            if (snapshot.hasData){
              return MainPage();
            }
            else{
              return LoginPage();
            }
          }),
    );
  }
}
