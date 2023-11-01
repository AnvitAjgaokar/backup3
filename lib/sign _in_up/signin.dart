import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/main/mainpage.dart';
import 'package:sem5demo3/sign%20_in_up/forgotpass.dart';
import 'package:sem5demo3/sign%20_in_up/newsignup.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  int count = 0;
  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isPasswordValid = false;
  bool isEmailValid = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isFocusedemail = false;
  bool _isFocusedpass = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),

      backgroundColor: Colors.white,
      body: Container(
        // alignment: Alignment.centerLeft,

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                 SizedBox(
                  height: 16.w,
                ),
                Container(
                    padding: EdgeInsets.only(left: 7.w),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login to your\nAccount",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 38.sp,color: Colors.black),
                    )),
                 SizedBox(
                  height: 7.h,
                ),
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
                  height: 4.h,
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: 5.5.w,
                      right: 5.5.w,
                    ),
                    height: 7.0.h,
                    child:
                    // Note: Same code is applied for the TextFormField as well
                    TextField(
                      obscureText: !isPasswordVisible,
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onChanged: validatePassword,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: _isFocusedpass
                              ? Colors.blueAccent.shade400
                              : Colors.grey.shade600,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isFocusedpass
                                ? Colors.blueAccent.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                        filled: true,
                        fillColor: _isFocusedpass
                            ? Colors.blueAccent.shade200.withOpacity(0.2)
                            : Colors.grey.shade600.withOpacity(0.2),
                        hintText: "Password",
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade600, fontSize: 12.sp),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0.sp,
                            color: _isFocusedpass
                                ? Colors.blueAccent.shade700
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0.sp,
                            color: Colors.blueAccent.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10.sp),
                        ),
                      ),
                    )),
                 SizedBox(
                  height: 7.h,
                ),

                Container(
                  width: double.infinity,
                  height: 6.3.h,
                  padding: EdgeInsets.only(left: 5.w, right: 5.w),
                  child: ElevatedButton(
                    onPressed: () {
                      _submitForm();
                      signIn();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.blueAccent.shade700,
                      elevation: 9,
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(fontSize: 13.sp),
                    ),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  alignment: Alignment.center,
                  child: TextButton(
                      onPressed: () {
                        Get.to(() => ForgotPage(),
                            transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
                      },
                      child: Text(
                        "Forgot the password?",
                        style: GoogleFonts.poppins(
                            color: Colors.blueAccent.shade700,fontSize: 11.sp),
                      )),
                ),
                 SizedBox(
                  height: 5.4.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            color: Colors.grey.shade400,
                            indent: 7.w,
                            thickness: 0.2.h,
                            endIndent: 7.w,
                          )),
                      Text(
                        "or",
                        style: GoogleFonts.poppins(
                            fontSize: 11.sp,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Divider(
                            color: Colors.grey.shade400,
                            endIndent: 7.w,
                            thickness: 0.2.h,
                            indent: 7.w,
                          )),
                    ]),


                 SizedBox(
                  height: 1.3.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style:
                      GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                    ),
                    // SizedBox(width: 1,),
                    TextButton(
                        onPressed: () {
                          Get.to(() => SignUpPage(),
                              transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));

                        },
                        child: Text(
                          "Sign up",
                          style: GoogleFonts.poppins(
                              fontSize: 13, color: Colors.blueAccent.shade700),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        count =1;
      });

        if (!isEmailValid && !isPasswordValid) {
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
                  'Invalid Credentials',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter a Valid Email Address and Password',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (!isPasswordValid) {
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
                  'Invalid Password!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter a Password with atleast one special character and digit',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.red.shade400,
                  ),
                ),
              ],
            ),
          ),
        );
      } else if (!isEmailValid) {
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
                  'Invalid Email!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter a Valid Email Address',
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
  }

  Future signIn() async{
    // await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: _emailController.text.trim(),
    //     password: _passwordController.text.trim());
    // Get.to(() => MainPage(),
    //     transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      Get.to(() => MainPage(),
          transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));

      setState(() {
        count = 1;
      });



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
                'Login Successful',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'You have been logged into the app successfully',
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
      if (count !=1){
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


}
