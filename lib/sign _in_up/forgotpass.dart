import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/sign%20_in_up/signin.dart';
import 'package:sizer/sizer.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  bool _isreset = false;
  bool isPasswordVisible = false;
  bool isPasswordValid = false;
  bool isEmailValid = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isFocusedemail = false;
  bool _isFocusedpass = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _emailController.text.trim());

      Get.to(() => LoginPage(),
          transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));



      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade100,
          duration: Duration(seconds: 3),
          showCloseIcon: true,
          closeIconColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Reset Email sent',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Your password reset e-mail has been sent changed',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.green.shade400,
                ),
              ),
            ],
          ),
        ),
      );
    } on FirebaseException catch (e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red.shade100,
          duration: Duration(seconds: 3),
          showCloseIcon: true,
          closeIconColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Please Enter Correct Credentials',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${e.toString()}',

                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.red.shade400,
                ),
              ),
            ],
          ),
        ),
      );

    }
  }

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
          padding: const EdgeInsets.only(left: 15),
          onPressed: () {
            // goSignin(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/forgotpassvg.svg",
                height: 280,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Enter your E-mail and we will send you a password reset link ",
                style: GoogleFonts.poppins(fontSize: 15, color: Colors.black45),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 40,
              ),
              // Container(
              //   height: 100,
              //   padding: const EdgeInsets.only(left: 15, right: 15),
              //   child: OutlinedButton(
              //       onPressed: () {
              //         // goEnterem(context);
              //       },
              //       child: Row(
              //         children: <Widget>[
              //           Container(
              //               width: 70,
              //               height: 70,
              //               decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   color: Colors.blueAccent.shade100
              //                       .withOpacity(0.2)),
              //               child: Icon(
              //                 Icons.email_rounded,
              //                 size: 35,
              //                 color: Colors.blueAccent.shade700,
              //               )),
              //           const SizedBox(
              //             width: 30,
              //           ),
              //           Container(
              //             padding: EdgeInsets.only(top: 25),
              //             child: Column(
              //               children: [
              //                 Container(
              //                     padding: EdgeInsets.only(right: 130),
              //                     child: Text("via Email",
              //                         style: GoogleFonts.poppins(
              //                             fontSize: 16, color: Colors.black))),
              //                 SizedBox(
              //                   height: 5,
              //                 ),
              //                 Container(
              //                     padding: EdgeInsets.only(right: 15),
              //                     child: Text("eg: johndoe@yourdomain.com",
              //                         style: GoogleFonts.poppins(
              //                             fontSize: 13,
              //                             color: Colors.grey.shade500)))
              //               ],
              //             ),
              //           ),
              //         ],
              //       )),
              // ),
              Container(
                  padding: EdgeInsets.only(
                    left: 5.5.w,
                    right: 5.5.w,
                  ),
                  height: 7.0.h,
                  child:
                  // Note: Same code is applied for the TextFormField as well
                  TextField(
                    controller: _emailController,
                    onChanged: validateEmail,
                    focusNode: _emailFocusNode,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.mail_rounded,
                        color: _isFocusedemail
                            ? Colors.blueAccent.shade400
                            : Colors.grey.shade600,
                      ),
                      hintText: "Email",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey.shade600, fontSize: 12.sp),
                      filled: true,
                      fillColor: _isFocusedemail
                          ? Colors.blueAccent.shade200.withOpacity(0.2)
                          : Colors.grey.shade600.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: _isFocusedemail
                              ? Colors.blueAccent.shade700
                              : Colors.transparent,
                        ),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.sp,
                          color: Colors.blueAccent.shade400,
                        ),
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                    ),
                  )),
              SizedBox(
                height: 1.h,
              ),
              // Visibility(
              //   visible: _ispassfield,
              //   child: Container(
              //       padding: EdgeInsets.only(
              //         left: 5.5.w,
              //         right: 5.5.w,
              //       ),
              //       height: 7.0.h,
              //       child:
              //       // Note: Same code is applied for the TextFormField as well
              //       TextField(
              //         obscureText: !isPasswordVisible,
              //         controller: _passwordController,
              //         focusNode: _passwordFocusNode,
              //         onChanged: validatePassword,
              //         decoration: InputDecoration(
              //           prefixIcon: Icon(
              //             Icons.lock,
              //             color: _isFocusedpass
              //                 ? Colors.blueAccent.shade400
              //                 : Colors.grey.shade600,
              //           ),
              //           suffixIcon: IconButton(
              //             onPressed: () {
              //               setState(() {
              //                 isPasswordVisible = !isPasswordVisible;
              //               });
              //             },
              //             icon: Icon(
              //               isPasswordVisible
              //                   ? Icons.visibility
              //                   : Icons.visibility_off,
              //               color: _isFocusedpass
              //                   ? Colors.blueAccent.shade400
              //                   : Colors.grey.shade600,
              //             ),
              //           ),
              //           filled: true,
              //           fillColor: _isFocusedpass
              //               ? Colors.blueAccent.shade200.withOpacity(0.2)
              //               : Colors.grey.shade600.withOpacity(0.2),
              //           hintText: "Confirm Password",
              //           hintStyle: GoogleFonts.poppins(
              //               color: Colors.grey.shade600, fontSize: 12.sp),
              //           enabledBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //               width: 2.0.sp,
              //               color: _isFocusedpass
              //                   ? Colors.blueAccent.shade700
              //                   : Colors.transparent,
              //             ),
              //             borderRadius: BorderRadius.circular(10.sp),
              //           ),
              //           focusedBorder: OutlineInputBorder(
              //             borderSide: BorderSide(
              //               width: 2.0.sp,
              //               color: Colors.blueAccent.shade400,
              //             ),
              //             borderRadius: BorderRadius.circular(10.sp),
              //           ),
              //         ),
              //       )),
              // ),

              const SizedBox(height: 40,),
              Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    passwordReset();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueAccent.shade700,
                    elevation: 9,
                  ),
                  child: Text(
                    'Reset Password',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(_handleEmailFocusChange);
    _passwordFocusNode.addListener(_handlePasswordFocusChange);
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_handleEmailFocusChange);
    _passwordFocusNode.removeListener(_handlePasswordFocusChange);
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleEmailFocusChange() {
    if (_emailFocusNode.hasFocus != _isFocusedemail) {
      setState(() {
        _isFocusedemail = _emailFocusNode.hasFocus;
      });
    }
  }

  void _handlePasswordFocusChange() {
    if (_passwordFocusNode.hasFocus != _isFocusedpass) {
      setState(() {
        _isFocusedpass = _passwordFocusNode.hasFocus;
      });
    }
  }

  void validatePassword(String? value) {
    if (value != null &&
        value.length >= 8 &&
        value.contains(RegExp(r'[0-9]')) &&
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        isPasswordValid = true;
      });
    } else {
      setState(() {
        isPasswordValid = false;
      });
    }
  }

  void validateEmail(String? value) {
    if (value != null &&
        value.isNotEmpty &&
        value.contains('@') &&
        value.contains('.') &&
        !value.startsWith('@') &&
        !value.endsWith('@') &&
        !value.startsWith('.') &&
        !value.endsWith('.')) {
      setState(() {
        isEmailValid = true;
      });
    } else {
      setState(() {
        isEmailValid = false;
      });
    }
  }
}
