import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sem5demo3/authentication/auth_controller.dart';




class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();


  //TextField Controllers to get data from TextFields
  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();


  /// This func will be used to register user with [EMAIL] & [Password]
  // void registerUser(String email, String password) {
  //   String? error = AuthenticationRepository.insatnce.createUserWithEmailAndPassword(email, password) as String?;
  //   if (error != null) {
  //     Get.showSnackbar(GetSnackBar(message: error.toString()));
  //   }
  // }


  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.insatnce.phoneAuthentication(phoneNo);
  }
}