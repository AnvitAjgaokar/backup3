

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sem5demo3/authentication/signup_controller.dart';
import 'package:sem5demo3/sign%20_in_up/otpscreen.dart';


class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();


    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30 - 10),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,
                decoration: const InputDecoration(label: Text("Username"), prefixIcon: Icon(Icons.person_outline_rounded)),
              ),
              const SizedBox(height: 30 - 20),
              TextFormField(
                controller: controller.email,
                decoration: const InputDecoration(label: Text("Email"), prefixIcon: Icon(Icons.email_outlined)),
              ),
              const SizedBox(height: 30 - 20),
              TextFormField(
                controller: controller.phoneNo,
                decoration: const InputDecoration(label: Text("PhoneNo"), prefixIcon: Icon(Icons.numbers)),
              ),
              const SizedBox(height: 30 - 20),
              TextFormField(
                controller: controller.password,
                decoration: const InputDecoration(label: Text("Password"), prefixIcon: Icon(Icons.fingerprint)),
              ),
              const SizedBox(height: 30 - 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      // var ph = '91'+controller.phoneNo.text;
                      // SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                      SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => OTPScreen()));
                      Get.to(() => const OTPScreen());
                    }
                  },
                  child: Text("Signup".toUpperCase()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}