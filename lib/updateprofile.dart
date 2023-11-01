import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/sign%20_in_up/newacc.dart';
import 'package:http/http.dart' as http;


class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key? key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  FirebaseAuth auth = FirebaseAuth.instance;

  File? _image;
  DateTime? _selectedDate;
  TextEditingController _nameController = TextEditingController();
  // TextEditingController _nicknameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _genderController = TextEditingController();

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

  Future<void> _updateUser() async {
    print("Updating User!!");



      var request = http.MultipartRequest('POST', Uri.parse('${httpImage}/user/'));
      print("before send");

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



    final String updateUserMutation = '''
      mutation() {
        updateFireuser(inputData: {
          userId: "${userid}"
          username: "${_nameController.text.trim()}",
          date: "${_dateController.text.trim()}"
          email: "${_emailController.text.trim()}"
          phoneno: "${_phoneController.text.trim()}"
          gender: "${_genderController.text.trim()}"    
        }) {
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
    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final MutationOptions options = MutationOptions(
      document: gql(updateUserMutation),
      // variables: {'id': userId},
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error updating user: ${result.exception.toString()}');
    } else {
      print('User updated successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.green.shade100,
          duration: const Duration(seconds: 6),
          showCloseIcon: true,
          closeIconColor: Colors.white,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                'Payment Successful',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Payment has been sucessfully added to your Wallet',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.green.shade400,
                ),
              ),
            ],
          ),
        ),
      );
    }


  }

  final String userDeatil = r'''
    query ($fireid: String!){
      usersbyfireid(fireid: $fireid) {
        id
        
      }
    }
  ''';

  Map<String, dynamic> datalist = {};
  
  dynamic userid ;

  @override
  Widget build(BuildContext context) {
    String fireid = auth.currentUser!.uid.toString();
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Update Your Profile",
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
          ),
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            Query(
              options: QueryOptions(
                document: gql(userDeatil),
                // variables: {'id': NewAcountone.idvaluee},
                variables: {'fireid':fireid},

              ),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.hasException) {
                  print(result.exception.toString());
                  return Center(
                    child: Text(
                        'Error fetching UserName: ${result.exception.toString()}'),
                  );
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }

                datalist = result.data?['usersbyfireid'] ?? [];
                userid  = datalist['id'];


                return Visibility(visible: false,child: Text("",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),));
              },

            ),

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 75,
                    backgroundColor: Colors.grey.shade300,
                    backgroundImage: _image != null ? FileImage(_image!) :null,
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
                    child: const Icon(Icons.edit, size: 20),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      primary: Colors.blueAccent.shade700,
                      padding: const EdgeInsets.all(8),
                      minimumSize: const Size(5, 5),
                    ),
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
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.only(left: 20, right: 20),
              height: 45,
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
            const SizedBox(
              height: 25,
            ),
            Container(
                padding: const EdgeInsets.only(
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
            const SizedBox(
              height: 25,
            ),
            Container(
                padding: const EdgeInsets.only(
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
            const SizedBox(
              height: 25,
            ),
            Container(
                padding: const EdgeInsets.only(
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
              height: 45,
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  _updateUser();
                  Navigator.pop(context);
                },
                child: Text(
                  'Update',
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.blueAccent.shade700,
                  elevation: 9,
                ),
              ),
            ),
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
    // _nicknameFocusNode.addListener(_nicknameFocusChange);
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
    // _nicknameController.dispose();
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

  // void _nicknameFocusChange() {
  //   if (_nicknameFocusNode.hasFocus != _nicknameFocusNode) {
  //     setState(() {
  //       _nickname = _nicknameFocusNode.hasFocus;
  //     });
  //   }
  // }

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
