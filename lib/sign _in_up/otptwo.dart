import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sem5demo3/authentication/otp_controller.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Timer? _timer;
  int _remainingTime = 60;
  // TextEditingController _otpcontroller = TextEditingController();
  var otp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Forgot Your Password",
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                SizedBox(
                  height: 250,
                ),
                Text(
                  "Code has been sent to johndoe@gmail.com",
                  style:
                  GoogleFonts.poppins(fontSize: 15, color: Colors.black87),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(10),
                        fieldHeight: 60,
                        fieldWidth: 45,
                        activeFillColor:
                        Colors.blueAccent.shade700.withOpacity(0.7),
                        activeColor: Colors.blueAccent.shade700,
                        selectedColor: Colors.blueAccent.shade700,
                        selectedFillColor:
                        Colors.blueAccent.shade700.withOpacity(0.7),
                        inactiveColor: Colors.grey.shade300),
                    onSubmitted: (code){
                      otp = code;
                      OTPController.instance.verifyOTP(otp);

                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Resend code in ",
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.black87),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "$_remainingTime",
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.blueAccent.shade700),
                    ),
                    Text(
                      " s",
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.black87),
                    )
                  ],
                ),
                SizedBox(
                  height: 80,
                ),
                Container(
                  width: double.infinity,
                  height: 45,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      OTPController.instance.verifyOTP(otp);
                    },
                    child: Text(
                      'Verify',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.blueAccent.shade700,
                      elevation: 9,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                if (_remainingTime == 0)
                  TextButton(
                    onPressed:(){
                      resendOTP;

                    },
                    child: Text('Resend OTP'),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void resendOTP() {
    if (_remainingTime == 0) {
      // Code to resend OTP
      setState(() {
        // OTPController.instance.verifyOTP();
        _remainingTime = 60;
      });
      startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
