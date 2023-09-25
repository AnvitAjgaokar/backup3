

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/authentication/otp_controller.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {



  @override
  Widget build(BuildContext context) {
    var otp;
    var optController = Get.put(OTPController());

    return Scaffold(

      body: Container(

        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter OTP",
              style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 80.0),
            ),

            const SizedBox(height: 40.0),

            const SizedBox(height: 20.0),
            OtpTextField(
                mainAxisAlignment: MainAxisAlignment.center,
                numberOfFields: 6,
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                obscureText: true,
                keyboardType: TextInputType.number,
                fieldWidth: 35,
                enabledBorderColor: Colors.blueAccent.shade700,
                disabledBorderColor: Colors.grey.shade400,
                onSubmit: (code) {
                  otp = code;
                  OTPController.instance.verifyOTP(otp);

                }),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () {
                OTPController.instance.verifyOTP(otp);

              }, child: const Text("Enter")),
            ),
          ],
        ),
      ),
    );
  }
}
