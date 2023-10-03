import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sem5demo3/addvehicle.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/main/mainpage.dart';
import 'package:sem5demo3/sign%20_in_up/newsignup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
class NewAcountone extends StatefulWidget {
  static String idvaluee='';
  const NewAcountone({Key? key}) : super(key: key);

  @override
  State<NewAcountone> createState() => _NewAcountoneState();
}

class _NewAcountoneState extends State<NewAcountone> {
  File? _image;
  DateTime? _selectedDate;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

  String _mainFireId ='';



  bool _name = false;
  bool _nickname = false;
  bool _date = false;
  bool _email = false;
  bool _phone = false;
  bool _gender = false;
  FocusNode _nameFocusNode = FocusNode();
  FocusNode _nicknameFocusNode = FocusNode();
  FocusNode _dateFocusNode = FocusNode();
  FocusNode _emailFocusNode = FocusNode();
  FocusNode _phoneFocusNode = FocusNode();
  FocusNode _genderFocusNode = FocusNode();

  Map<String, dynamic> idlist = {};
  Map<String, dynamic> walletidlist = {};
  dynamic idval;
  dynamic walletidval;

  Future<void> _createWallet() async {
    print("Creating Wallet");

// Convert the resized image to base64

    final String createWalletMutation = '''
      mutation () {
        createWallet(email: "${SignUpPage.email}", fireid: "${_mainFireId.toString()}") {
          walletname {
            id
            email
            fireid
     

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


  _createUser() async {
    var request = http.MultipartRequest('POST', Uri.parse('${httpImage}/user/'));
    print("before send");
    request.fields.addAll({
      'username': "${_nameController.text.trim()}",
      'date': "${_dateController.text.trim()}",
      'email': "${SignUpPage.email.toString()}",
      'phoneno': "${_phoneController.text.trim()}",
      'gender': "${_genderController.text.trim()}",
      'fireid': "${_mainFireId.toString()}",
    });
    print(_image!.path.toString());
    request.files.add(await http.MultipartFile.fromPath('profilephoto', _image!.path.toString()));
    // print("after request send ");

    http.StreamedResponse response = await request.send();


    if (response.statusCode == 200) {
      print(response);
      print("Photo Uploaded successfully with user");
    }
    else {
      print("ERROR");
      print(response.reasonPhrase);
    }
  }



  // Future<void> _updateUser() async {
  //     print("Updating User!!");
  //     final String updateUserMutation = '''
  //     mutation() {
  //       updateUser(inputData: {
  //         userId: "${idval}"
  //         username: "${_nameController.text.trim()}",
  //         date: "${_dateController.text.trim()}"
  //         phoneno: "${_phoneController.text.trim()}"
  //         gender: "${_genderController.text.trim()}"
  //         fireid: "${_mainFireId}"
  //       }) {
  //         user {
  //           id
  //           username
  //           date
  //           phoneno
  //           gender
  //           fireid
  //         }
  //       }
  //     }
  //
  //   ''';
  //     // final HttpLink httpLink = HttpLink(
  //     //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL
  //
  //     final GraphQLClient client = GraphQLClient(
  //       cache: GraphQLCache(),
  //       link: httpLink,
  //     );
  //
  //     final MutationOptions options = MutationOptions(
  //       document: gql(updateUserMutation),
  //       // variables: {'id': userId},
  //     );
  //
  //     final QueryResult result = await client.mutate(options);
  //
  //   if (result.hasException) {
  //     print('Error updating user: ${result.exception.toString()}');
  //   } else {
  //     print('User updated successfully');
  //   }
  // }

  // _createUserUpload() async {
  //   var request = http.MultipartRequest('POST', Uri.parse('${httpImage}/user/'));
  //
  //   request.files.add(await http.MultipartFile.fromPath('userImages', '${_image!.path.toString()}'));
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print(response);
  //     print("Photo uploaded!!!!");
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //     print("Failed!!!!");
  //   }
  // }




  final String getIdQuery = r'''
    query ($email: String!){
      usersbyemail(email: $email) {
        id
      }
    }
  ''';

  final String getWalletIdQuery = r'''
    query ($email: String!){
      balancebyemail(email: $email) {
        id
      }
    }
  ''';


//   Future<void> _createWallet() async {
//     print("Creating Wallet");
//
// // Convert the resized image to base64
//
//     final String createWalletMutation = '''
//       mutation () {
//         createWallet(useridval: "${idval.toString()}") {
//           walletname {
//             id
//             useridval
//
//
//           }
//         }
//       }
//     ''';
//
//     final GraphQLClient _client = client.value;
//
//     final MutationOptions options = MutationOptions(
//       document: gql(createWalletMutation),
//     );
//
//     final QueryResult result = await _client.mutate(options);
//
//     if (result.hasException) {
//       print('Error creating wallet: ${result.exception.toString()}');
//     } else {
//       print('Wallet created successfully!');
//       // Clear form fields after successful user creation
//
//     }
//   }

  Future<void> _updateWallet() async {
    print("Updating Wallet!!");
    final String updateWalletMutation = '''
      mutation() {
        updateWallet(inputData: {
          balancenameId: "${walletidval}"
          fireid: "${_mainFireId}",   
        }) {
          balancename {
            id
            fireid
          }
        }
      }

    ''';
    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final MutationOptions options = MutationOptions(
        document: gql(updateWalletMutation),
        // variables: {'id': userId},
        // variables: {'id': walletidval}
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error updating Wallet: ${result.exception.toString()}');
    } else {
      print('Wallet updated successfully');
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    String fireid = auth.currentUser!.uid.toString();
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    // final controller = Get.find<TextEditingController>();
    return WillPopScope(
      onWillPop: () async => false,
      child: GraphQLProvider(
        client: client,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Fill Your Profile",
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
            ),
            // leading: IconButton(
            //   padding: const EdgeInsets.only(left: 15),
            //   onPressed: () {},
            //   icon: const Icon(Icons.arrow_back),
            //   color: Colors.black,
            // ),
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(children: [




              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.grey.shade300,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? const Icon(
                        Icons.person_2,
                        size: 150,
                        color: Colors.white,
                      )
                          : null,
                    ),
                  ),
                  Positioned(
                    bottom: 2,
                    right: 110,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Select Profile Picture'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.photo),
                                    title: const Text('Choose from Gallery'),
                                    onTap: () {
                                      _pickImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.camera_alt),
                                    title: const Text('Take a Photo'),
                                    onTap: () {
                                      _pickImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        primary: Colors.blueAccent.shade700,
                        padding: const EdgeInsets.all(8),
                        minimumSize: const Size(5, 5),
                      ),
                      child: const Icon(Icons.edit, size: 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 7.0.h,
                  child:
                  // Note: Same code is applied for the TextFormField as well
                  TextField(
                    controller: _nameController,
                    focusNode: _nameFocusNode,
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey.shade600, fontSize: 14),
                      filled: true,
                      fillColor: _name
                          ? Colors.blueAccent.shade200.withOpacity(0.2)
                          : Colors.grey.shade600.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: _name
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
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                height: 7.0.h,
                child: TextField(
                  controller: _dateController,
                  focusNode: _dateFocusNode,
                  decoration: InputDecoration(
                    hintText: "Date of Birth",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade600, fontSize: 14),
                    filled: true,
                    fillColor: _date
                        ? Colors.blueAccent.shade200.withOpacity(0.2)
                        : Colors.grey.shade600.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color:
                        _date ? Colors.blueAccent.shade700 : Colors.transparent,
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
                    suffixIcon: IconButton(
                      onPressed: () {
                        // Code to open calendar
                        _selectDate();
                      },
                      icon: Icon(
                        Icons.calendar_month_rounded,
                        color: _date
                            ? Colors.blueAccent.shade400
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 25,
              // ),
              // Container(
              //     padding: EdgeInsets.only(
              //       left: 20,
              //       right: 20,
              //     ),
              //     height: 45,
              //     child:
              //     // Note: Same code is applied for the TextFormField as well
              //     TextField(
              //       controller: _emailController,
              //       focusNode: _emailFocusNode,
              //       decoration: InputDecoration(
              //         prefixIcon: Icon(
              //           Icons.email_outlined,
              //           color: _email
              //               ? Colors.blueAccent.shade400
              //               : Colors.grey.shade600,
              //         ),
              //         hintText: "Email",
              //         hintStyle: GoogleFonts.poppins(
              //             color: Colors.grey.shade600, fontSize: 14),
              //         filled: true,
              //         fillColor: _email
              //             ? Colors.blueAccent.shade200.withOpacity(0.2)
              //             : Colors.grey.shade600.withOpacity(0.2),
              //         enabledBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             width: 2.0,
              //             color: _email
              //                 ? Colors.blueAccent.shade700
              //                 : Colors.transparent,
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //         focusedBorder: OutlineInputBorder(
              //           borderSide: BorderSide(
              //             width: 2.0,
              //             color: Colors.blueAccent.shade400,
              //           ),
              //           borderRadius: BorderRadius.circular(10),
              //         ),
              //       ),
              //     )),
              const SizedBox(
                height: 25,
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 7.0.h,
                  child: TextField(
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: GoogleFonts.poppins(
                            color: Colors.grey.shade600, fontSize: 14),
                        filled: true,
                        fillColor: _phone
                            ? Colors.blueAccent.shade200.withOpacity(0.2)
                            : Colors.grey.shade600.withOpacity(0.2),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2.0,
                            color: _phone
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
                        prefixIcon: Icon(
                          Icons.phone,
                          color: _phone
                              ? Colors.blueAccent.shade400
                              : Colors.grey.shade600,
                        ),
                        // prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
                        prefixStyle: GoogleFonts.poppins(
                            color: Colors.black, fontSize: 15.5)),
                  )),
              const SizedBox(
                height: 25,
              ),
              Container(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  height: 7.0.h,
                  child:
                  // Note: Same code is applied for the TextFormField as well
                  TextField(
                    controller: _genderController,
                    focusNode: _genderFocusNode,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          _selectGender();
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down_rounded,
                          size: 31,
                        ),
                        color: _gender
                            ? Colors.blueAccent.shade400
                            : Colors.grey.shade600,
                      ),
                      hintText: "Gender",
                      hintStyle: GoogleFonts.poppins(
                          color: Colors.grey.shade600, fontSize: 14),
                      filled: true,
                      fillColor: _gender
                          ? Colors.blueAccent.shade200.withOpacity(0.2)
                          : Colors.grey.shade600.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          width: 2.0,
                          color: _gender
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
                height: 35,
              ),

              // Query(
              //   options: QueryOptions(
              //     document: gql(getIdQuery),
              //     variables: {'email' :SignUpPage.email.toString() },
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
              //         child: CircularProgressIndicator(
              //           color: Colors.transparent,
              //           backgroundColor: Colors.transparent,
              //         ),
              //       );
              //     }
              //
              //     idlist = result.data?['usersbyemail'] ?? [];
              //     idval = idlist['id'];
              //
              //     return const Visibility(visible: false, child: Text('done'));
              //   },
              // ),
              //
              // Query(
              //   options: QueryOptions(
              //     document: gql(getWalletIdQuery),
              //     variables: {'email' :SignUpPage.email.toString() },
              //   ),
              //   builder: (QueryResult result, {fetchMore, refetch}) {
              //     if (result.hasException) {
              //       print(result.exception.toString());
              //       return Center(
              //         child: Text(
              //             'Error fetching walletid: ${result.exception
              //                 .toString()}'),
              //       );
              //     }
              //
              //     if (result.isLoading) {
              //       return const Center(
              //         child: CircularProgressIndicator(
              //           color: Colors.transparent,
              //           backgroundColor: Colors.transparent,
              //         ),
              //       );
              //     }
              //
              //     walletidlist = result.data?['balancebyemail'] ?? [];
              //     walletidval = walletidlist['id'];
              //
              //     return const Visibility(visible: false, child: Text('done'));
              //   },
              // ),

              Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(AddVehiclePage(),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1),);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueAccent.shade200.withOpacity(0.2),
                    elevation: 0,

                  ),
                  child: Text(
                    'Add Vehicle',
                    style: GoogleFonts.poppins(fontSize: 15,color: Colors.blueAccent.shade700),
                  ),
                ),
              ),

              SizedBox(height: 30,),

              Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty ||
                        _dateController.text.isEmpty ||
                        _phoneController.text.isEmpty ||
                        _genderController.text.isEmpty){
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
                                'Fields cannot be Empty',

                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Enter Values properly',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );

                    } else {
                      setState(() {
                        NewAcountone.idvaluee = idval.toString();
                        _mainFireId = fireid;
                      });
                      // print('list: ${idlist}');
                      // print('email ${SignUpPage.email.toString()}');
                      // print('id ${idval.toString()}');
                      // print("The fireID: ${_mainFireId}");
                      // print("The image Path: ${_image!.path.toString()}");
                      // _updateUser();
                      // _updateWallet();
                      _createWallet();
                      _createUser();
                      // _createUserUpload();
                      Get.offAll(const MainPage(),transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1),);
                      print("The id is: ${walletidlist}");
                    }



                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueAccent.shade700,
                    elevation: 9,
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.poppins(fontSize: 15),
                  ),
                ),
              ),


            ]),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(source: source);
    File? img = File(pickedImage!.path);
    img = await _cropImage(imageFile: img);

    if (pickedImage != null) {
      setState(() {
        // _image = File(pickedImage.path);
        _image = img;
      });
    }
  }

  Future<File?> _cropImage({required File imageFile}) async {
    CroppedFile? croppedImage =
    await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedImage == null) return null;
    return File(croppedImage.path);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        final formattedDate = DateFormat.MMMM().format(picked);
        _dateController.text = "${picked.day}-$formattedDate-${picked.year}";
      });
    }
  }

  void _selectGender() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _genderController.text,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                ),
              ),
              ListTile(
                title: const Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _genderController.text,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                ),
              ),
              ListTile(
                title: const Text('Others'),
                leading: Radio<String>(
                  value: 'Others',
                  groupValue: _genderController.text,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );

    if (result != null) {
      setState(() {
        _genderController.text = result;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _nameFocusNode.addListener(_nameFocusChange);
    _nicknameFocusNode.addListener(_nicknameFocusChange);
    _dateFocusNode.addListener(_dateFocusChange);
    _emailFocusNode.addListener(_emailFocusChange);
    _phoneFocusNode.addListener(_phoneFocusChange);
    _genderFocusNode.addListener(_genderFocusChange);
  }

  @override
  void dispose() {
    _nameFocusNode.removeListener(() {});
    _nicknameFocusNode.removeListener(() {});
    _dateFocusNode.removeListener(() {});
    _emailFocusNode.removeListener(() {});
    _phoneFocusNode.removeListener(() {});
    _genderFocusNode.removeListener(() {});
    _nameController.dispose();
    _nicknameController.dispose();
    _dateController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  void _nameFocusChange() {
    if (_nameFocusNode.hasFocus != _nameFocusNode) {
      setState(() {
        _name = _nameFocusNode.hasFocus;
      });
    }
  }

  void _nicknameFocusChange() {
    if (_nicknameFocusNode.hasFocus != _nicknameFocusNode) {
      setState(() {
        _nickname = _nicknameFocusNode.hasFocus;
      });
    }
  }

  void _dateFocusChange() {
    if (_dateFocusNode.hasFocus != _dateFocusNode) {
      setState(() {
        _date = _dateFocusNode.hasFocus;
      });
    }
  }

  void _emailFocusChange() {
    if (_emailFocusNode.hasFocus != _emailFocusNode) {
      setState(() {
        _email = _emailFocusNode.hasFocus;
      });
    }
  }

  void _phoneFocusChange() {
    if (_phoneFocusNode.hasFocus != _phoneFocusNode) {
      setState(() {
        _phone = _phoneFocusNode.hasFocus;
      });
    }
  }

  void _genderFocusChange() {
    if (_genderFocusNode.hasFocus != _genderFocusNode) {
      setState(() {
        _gender = _genderFocusNode.hasFocus;
      });
    }
  }
}
