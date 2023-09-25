import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sem5demo3/client.dart';

class NewAcount extends StatefulWidget {
  const NewAcount({Key? key}) : super(key: key);

  @override
  State<NewAcount> createState() => _NewAcountState();
}

class _NewAcountState extends State<NewAcount> {
  File? _image;

  DateTime? _selectedDate;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

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

  Future<void> _createUser() async {
    print("Creating user");

// Convert the resized image to base64

    final String createUserMutation = '''
      mutation () {
        createUser(username: "${_nameController.text}", date: "${_dateController.text}", email: "${_emailController.text}", phoneno: ${_phoneController.text}, gender: "${_genderController.text}") {
          user {
            id
            username
            date
            email
            phoneno
            gender

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
      _nameController.clear();
      _dateController.clear();
      _emailController.clear();
      _phoneController.clear();
      _genderController.clear();
    }
  }






  //
  // Future<void> _uploadPhoto(GraphQLClient client) async {
  //   if (_image == null) {
  //     return;
  //   }
  //
  //   String base64Image = base64Encode(await _image!.readAsBytes());
  //
  //   final String uploadPhotoMutation = '''
  //     mutation(\$input: UploadPhotoInput!) {
  //       uploadPhoto(input: \$input) {
  //         success
  //       }
  //     }
  //   ''';
  //
  //   final MutationOptions options = MutationOptions(
  //     document: gql(uploadPhotoMutation),
  //     variables: {
  //       'input': {'user_id': '1', 'photo': base64Image},  // Replace USER_ID with the actual user ID
  //     },
  //   );
  //
  //   final QueryResult result = await client.mutate(options);
  //
  //   if (result.hasException) {
  //     print('Error uploading photo: ${result.exception.toString()}');
  //   } else {
  //     print('Photo uploaded successfully');
  //   }
  // }

  @override
  Widget build(BuildContext context) {

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Fill Your Profile",
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
          ),
          leading: IconButton(
            padding: EdgeInsets.only(left: 15),
            onPressed: () {},
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            // Stack(
            //   alignment: Alignment.center,
            //   children: [
            //     Container(
            //       alignment: Alignment.center,
            //       child: CircleAvatar(
            //         radius: 75,
            //         backgroundColor: Colors.grey.shade300,
            //         backgroundImage: _image != null ? FileImage(_image!) : null,
            //         child: _image == null
            //             ? Icon(
            //                 Icons.person_2,
            //                 size: 150,
            //                 color: Colors.white,
            //               )
            //             : null,
            //       ),
            //     ),
            //     Positioned(
            //       bottom: 2,
            //       right: 110,
            //       child: ElevatedButton(
            //         onPressed: () {
            //           showDialog(
            //             context: context,
            //             builder: (BuildContext context) {
            //               return AlertDialog(
            //                 title: Text('Select Profile Picture'),
            //                 content: Column(
            //                   mainAxisSize: MainAxisSize.min,
            //                   children: [
            //                     ListTile(
            //                       leading: Icon(Icons.photo),
            //                       title: Text('Choose from Gallery'),
            //                       onTap: () {
            //                         _pickImage(ImageSource.gallery);
            //                         Navigator.of(context).pop();
            //                       },
            //                     ),
            //                     ListTile(
            //                       leading: Icon(Icons.camera_alt),
            //                       title: Text('Take a Photo'),
            //                       onTap: () {
            //                         _pickImage(ImageSource.camera);
            //                         Navigator.of(context).pop();
            //                       },
            //                     ),
            //                   ],
            //                 ),
            //               );
            //             },
            //           );
            //         },
            //         child: Icon(Icons.edit, size: 20),
            //         style: ElevatedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //           primary: Colors.blueAccent.shade700,
            //           padding: EdgeInsets.all(8),
            //           minimumSize: Size(5, 5),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 25,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 45,
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
            SizedBox(
              height: 25,
            ),
            // Container(
            //     padding: EdgeInsets.only(
            //       left: 20,
            //       right: 20,
            //     ),
            //     height: 45,
            //     child:
            //         // Note: Same code is applied for the TextFormField as well
            //         TextField(
            //       controller: _nicknameController,
            //       focusNode: _nicknameFocusNode,
            //       decoration: InputDecoration(
            //         hintText: "Nickname",
            //         hintStyle: GoogleFonts.poppins(
            //             color: Colors.grey.shade600, fontSize: 14),
            //         filled: true,
            //         fillColor: _nickname
            //             ? Colors.blueAccent.shade200.withOpacity(0.2)
            //             : Colors.grey.shade600.withOpacity(0.2),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(
            //             width: 2.0,
            //             color: _nickname
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
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 45,
              child: TextField(
                controller: _dateController,
                focusNode: _dateFocusNode,
                keyboardType: TextInputType.number,
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
            SizedBox(
              height: 25,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 45,
                child:
                    // Note: Same code is applied for the TextFormField as well
                    TextField(
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: _email
                          ? Colors.blueAccent.shade400
                          : Colors.grey.shade600,
                    ),
                    hintText: "Email",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade600, fontSize: 14),
                    filled: true,
                    fillColor: _email
                        ? Colors.blueAccent.shade200.withOpacity(0.2)
                        : Colors.grey.shade600.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: _email
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
              height: 25,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 45,
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
            SizedBox(
              height: 25,
            ),
            Container(
                padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                height: 45,
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
                      icon: Icon(
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
            SizedBox(
              height: 25,
            ),
            // Container(
            //   width: double.infinity,
            //   height: 45,
            //   padding: EdgeInsets.only(left: 20, right: 20),
            //   child: ElevatedButton(
            //     onPressed:
            //       // _createUser,
            //     print("hello"),
            //
            //     child: Text(
            //       'Continue',
            //       style: GoogleFonts.poppins(fontSize: 15),
            //     ),
            //     style: ElevatedButton.styleFrom(
            //       shape: StadiumBorder(),
            //       backgroundColor: Colors.blueAccent.shade700,
            //       elevation: 9,
            //     ),
            //   ),
            // ),
          ]),
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
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Male'),
                leading: Radio<String>(
                  value: 'Male',
                  groupValue: _genderController.text,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                ),
              ),
              ListTile(
                title: Text('Female'),
                leading: Radio<String>(
                  value: 'Female',
                  groupValue: _genderController.text,
                  onChanged: (value) {
                    Navigator.pop(context, value);
                  },
                ),
              ),
              ListTile(
                title: Text('Others'),
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
