import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/sign%20_in_up/newacc.dart';
import 'package:sem5demo3/sign%20_in_up/signin.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatefulWidget {
  static String email='';
  const SignUpPage({Key? key}) : super(key: key);



  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int count = 0;
  bool rememberMe = false;
  bool isPasswordVisible1 = false;
  bool isPasswordValid1 = false;
  bool isPasswordVisible2 = false;
  bool isPasswordValid2 = false;
  bool isEmailValid = false;
  final TextEditingController _passwordController1 = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isFocusedemail = false;
  bool _isFocusedpass1 = false;
  bool _isFocusedpass2 = false;
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _passwordFocusNode1 = FocusNode();
  FocusNode _passwordFocusNode2 = FocusNode();
  // final controller = Get.put(TextEditingController());


  final _formKey = GlobalKey<FormState>();

  Future<void> _createWallet() async {
    print("Creating Wallet");

// Convert the resized image to base64

    final String createWalletMutation = '''
      mutation () {
        createWallet(email: "${_emailController.text.trim()}") {
          walletname {
            id
            email
     

          }
        }
      }
    ''';

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createWalletMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating wallet: ${result.exception.toString()}');
    } else {
      print('Wallet created successfully!');
      // Clear form fields after successful user creation

    }
  }



  Future _signUp() async {
    // if (passwordcorrect()) {
    //   await FirebaseAuth.instance.createUserWithEmailAndPassword(
    //       email: _emailController.text.trim(),
    //       password: _passwordController1.text.trim());
    //
    //   Get.to(() => NewAcount(),
    //       transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
    // }

    try {
      if (passwordcorrect()) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController1.text.trim());

        Get.to(() => NewAcountone(),
            transition: Transition.cupertinoDialog, duration: Duration(seconds: 1),);
        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewAcountone(value: SignUpPage.email.toString(),)));
      };



      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     backgroundColor: Colors.green.shade100,
      //     duration: Duration(seconds: 3),
      //     showCloseIcon: true,
      //     closeIconColor: Colors.white,
      //     content: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       mainAxisSize: MainAxisSize.max,
      //       children: [
      //         Text(
      //           'Login Successful',
      //           style: GoogleFonts.poppins(
      //             fontSize: 18,
      //             fontWeight: FontWeight.bold,
      //             color: Colors.green,
      //           ),
      //         ),
      //         SizedBox(height: 8),
      //         Text(
      //           'You have been logged into the app successfully',
      //           style: GoogleFonts.poppins(
      //             fontSize: 16,
      //             color: Colors.green.shade400,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // );
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



  Future<void> _createUser() async {
    print("Creating user");

// Convert the resized image to base64

    final String createUserMutation = '''
      mutation () {
        createUser(email: "${_emailController.text}") {
          user {
            id
            email
     

          }
        }
      }
    ''';

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createUserMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating user: ${result.exception.toString()}');
    } else {
      print('User created successfully!');
      // Clear form fields after successful user creation
      _emailController.clear();

    }
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){},
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),

      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.only(left: 0),
        // alignment: Alignment.centerLeft,

        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Query(
                //   options: QueryOptions(
                //     document: gql(getIdQuery),
                //     variables: {'email' :_emailController.text.trim() },
                //   ),
                //   builder: (QueryResult result, {fetchMore, refetch}) {
                //     if (result.hasException) {
                //       print(result.exception.toString());
                //       return Center(
                //         child: Text(
                //             'Error fetching id: ${result.exception
                //                 .toString()}'),
                //       );
                //     }
                //
                //     if (result.isLoading) {
                //       return const Center(
                //         child: CircularProgressIndicator(),
                //       );
                //     }
                //
                //     idlist = result.data?['usersbyemail'] ?? [];
                //
                //     print(idval);
                //
                //     return Visibility(visible: false, child: Text('done'));
                //   },
                // ),

                 SizedBox(
                  height: 7.h,
                ),
                Container(
                    padding: EdgeInsets.only(left: 5.5.w),
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Create your\nAccount",
                      textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 45),
                    )),
                const SizedBox(
                  height: 50,
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
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
                            color: Colors.grey.shade600, fontSize: 14),
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.blueAccent.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
                const SizedBox(
                  height: 15,
                ),
                Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    height: 7.0.h,
                    child:
                    // Note: Same code is applied for the TextFormField as well
                    TextField(
                      enableInteractiveSelection: false,
                      obscureText: !isPasswordVisible1,
                      controller: _passwordController1,
                      focusNode: _passwordFocusNode1,
                      onChanged: validatePassword1,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: _isFocusedpass1
                              ? Colors.blueAccent.shade400
                              : Colors.grey.shade600,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible1 = !isPasswordVisible1;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible1
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isFocusedpass1
                                ? Colors.blueAccent.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                        filled: true,
                        fillColor: _isFocusedpass1
                            ? Colors.blueAccent.shade200.withOpacity(0.2)
                            : Colors.grey.shade600.withOpacity(0.2),
                        hintText: "Password",
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade600, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: _isFocusedpass1
                                ? Colors.blueAccent.shade700
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.blueAccent.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),

                const SizedBox(
                  height: 15,
                ),

                // confirm password
                Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    height: 7.0.h,
                    child:
                    // Note: Same code is applied for the TextFormField as well
                    TextField(
                      enableInteractiveSelection: false,
                      obscureText: !isPasswordVisible2,
                      controller: _passwordController2,
                      focusNode: _passwordFocusNode2,
                      onChanged: validatePassword2,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: _isFocusedpass2
                              ? Colors.blueAccent.shade400
                              : Colors.grey.shade600,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible2 = !isPasswordVisible2;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: _isFocusedpass2
                                ? Colors.blueAccent.shade400
                                : Colors.grey.shade600,
                          ),
                        ),
                        filled: true,
                        fillColor: _isFocusedpass2
                            ? Colors.blueAccent.shade200.withOpacity(0.2)
                            : Colors.grey.shade600.withOpacity(0.2),
                        hintText: "Confirm Password",
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade600, fontSize: 14),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: _isFocusedpass2
                                ? Colors.blueAccent.shade700
                                : Colors.transparent,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: Colors.blueAccent.shade400,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    )),
                 SizedBox(
                  height: 6.0.h,
                ),
                // Container(
                //   padding: EdgeInsets.only(right: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       const SizedBox(width: 10),
                //       Checkbox(
                //         side: BorderSide(
                //             color: Colors.blueAccent.shade700, width: 2),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(6),
                //           // side: BorderSide(color: Colors.blueAccent.shade700),
                //         ),
                //         value: rememberMe,
                //         activeColor: Colors.blueAccent.shade700,
                //         checkColor: Colors.white,
                //         onChanged: (newValue) {
                //           setState(() {
                //             rememberMe = newValue ?? false;
                //           });
                //         },
                //       ),
                //       const SizedBox(width: 0),
                //       Text(
                //         'Remember me',
                //         style: GoogleFonts.poppins(
                //             fontSize: 14, color: Colors.black),
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(
                //   height: 10,
                // ),




                Container(
                  width: double.infinity,
                  height: 5.9.h,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        SignUpPage.email = _emailController.text.trim();
                      });
                      _submitForm();
                      _signUp();
                      _createUser();
                      _createWallet();

                      // print("email : ${_emailController.text.trim()}");

                    },
                    child: Text(
                      'Sign up',
                      style: GoogleFonts.poppins(fontSize: 15),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.blueAccent.shade700,
                      elevation: 9,
                    ),
                  ),
                ),
                 SizedBox(
                  height: 7.0.h,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Divider(
                            color: Colors.grey.shade400,
                            indent: 30,
                            thickness: 1,
                            endIndent: 10,
                          )),
                      Text(
                        "or",
                        style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      ),
                      Expanded(
                          child: Divider(
                            color: Colors.grey.shade400,
                            endIndent: 30,
                            thickness: 1,
                            indent: 10,
                          )),
                    ]),

                 SizedBox(
                  height: 3.h,
                ),



                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an Account?",
                      style:
                      GoogleFonts.poppins(fontSize: 13, color: Colors.grey),
                    ),
                    // SizedBox(width: 1,),
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginPage(),
                              transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
                          // print('idval: ${idval}, ${idlist}');
                        },
                        child: Text(
                          "Login",
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

  void validatePassword1(String? value) {
    if (value != null &&
        value.length >= 8 &&
        value.contains(RegExp(r'[0-9]')) &&
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        isPasswordValid1 = true;
      });
    } else {
      setState(() {
        isPasswordValid1 = false;
      });
    }
  }

  void validatePassword2(String? value) {
    if (value != null &&
        value.length >= 8 &&
        value.contains(RegExp(r'[0-9]')) &&
        value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        isPasswordValid2 = true;
      });
    } else {
      setState(() {
        isPasswordValid2 = false;
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
      // if (isEmailValid && isPasswordValid1 && isPasswordValid2 ) {
      //   // goSignin(context);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       backgroundColor: Colors.green.shade100,
      //       duration: Duration(seconds: 3),
      //       showCloseIcon: true,
      //       closeIconColor: Colors.white,
      //       content: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         mainAxisSize: MainAxisSize.max,
      //         children: [
      //           Text(
      //             'Congratulations',
      //             style: GoogleFonts.poppins(
      //               fontSize: 18,
      //               fontWeight: FontWeight.bold,
      //               color: Colors.green,
      //             ),
      //           ),
      //           SizedBox(height: 8),
      //           Text(
      //             'Account created Successfully!!',
      //             style: GoogleFonts.poppins(
      //               fontSize: 16,
      //               color: Colors.green.shade400,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   );}
        if (!isEmailValid && !isPasswordValid1 && !isPasswordValid2) {
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
                  'Fields cannot be Empty!',
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
      } else if (!isPasswordValid1) {
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
                  'Enter a Password with 8 character or more and atleast one special character and digit',
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
      }  else if (!passwordcorrect()) {
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
                  'Passwords do not match!',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Enter correct password again',
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
    _passwordFocusNode1.addListener(_handlePasswordFocusChange1);
    _passwordFocusNode2.addListener(_handlePasswordFocusChange2);

  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_handleEmailFocusChange);
    _passwordFocusNode1.removeListener(_handlePasswordFocusChange1);
    _passwordFocusNode2.removeListener(_handlePasswordFocusChange2);

    // _emailController.dispose();
    _passwordController1.dispose();
    _passwordController2.dispose();

    super.dispose();
  }

  void _handleEmailFocusChange() {
    if (_emailFocusNode.hasFocus != _isFocusedemail) {
      setState(() {
        _isFocusedemail = _emailFocusNode.hasFocus;
      });
    }
  }

  void _handlePasswordFocusChange1() {
    if (_passwordFocusNode1.hasFocus != _isFocusedpass1) {
      setState(() {
        _isFocusedpass1 = _passwordFocusNode1.hasFocus;
      });
    }
  }


  void _handlePasswordFocusChange2() {
    if (_passwordFocusNode2.hasFocus != _isFocusedpass2) {
      setState(() {
        _isFocusedpass2 = _passwordFocusNode2.hasFocus;
      });
    }
  }

  bool passwordcorrect() {
    if (_passwordController1.text.trim() == _passwordController2.text.trim()) {
      return true;
    }
    else {
      return false;
    }
  }
}
