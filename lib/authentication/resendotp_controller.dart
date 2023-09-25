import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sem5demo3/authentication/auth_controller.dart';




class ResendOtpcont extends GetxController {
  static ResendOtpcont get instance => Get.find();


  //TextField Controllers to get data from TextFields

  var phoneNo ;


  /// This func will be used to register user with [EMAIL] & [Password]
  // void registerUser(String email, String password) {
  //   String? error = AuthenticationRepository.insatnce.createUserWithEmailAndPassword(email, password) as String?;
  //   if (error != null) {
  //     Get.showSnackbar(GetSnackBar(message: error.toString()));
  //   }
  // }


  //Get phoneNo from user (Screen) and pass it to Auth Repository for Firebase Authentication
  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.insatnce.phoneAuthentication(phoneNo.toString());
  }
}