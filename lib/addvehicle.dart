import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/selectvehicle.dart';

class AddVehiclePage extends StatefulWidget {
  @override
  _AddVehiclePageState createState() => _AddVehiclePageState();
}

class _AddVehiclePageState extends State<AddVehiclePage> {
  String _vehicleModel = '';
  String _vehicleNumber = '';
  final TextEditingController _modelname = TextEditingController();
  final TextEditingController _platenum = TextEditingController();

  bool _isFocusedVname = false;
  bool _isFocusedVnumber = false;
  FocusNode _vNameFocusNode = FocusNode();
  FocusNode _vNumberFocusNode = FocusNode();

  FirebaseAuth auth = FirebaseAuth.instance;
  String mainfireid = '';

  int count =0;


  Future<void> _createNewcar() async {
    print("Creating new Car");

// Convert the resized image to base64

    final String createCarMutation = '''
      mutation () {
        createVehicle(modelname: "${_modelname.text}", platenum: "${_platenum.text}",fireid: "${mainfireid}") {
          vehicle {
            modelname
            platenum
            fireid

          }
        }
      }
    ''';

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createCarMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating car: ${result.exception.toString()}');
    } else {
      print('Car created successfully!');

    }
  }

  @override
  Widget build(BuildContext context) {
    String fireid = auth.currentUser!.uid.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add New Vehicle',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15),
          onPressed: () {
            Navigator.pop(context); // Go back when the back button is pressed
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/addvehiclesvg.svg',
                height: 250,
              ),

              const SizedBox(
                height: 10,
              ),

              Text("Add Your New Vehicle Details",style: GoogleFonts.poppins(fontSize: 15),textAlign: TextAlign.center,),


              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                height: 50,
                child: TextField(
                  controller: _modelname,
                  focusNode: _vNameFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.directions_car_rounded,
                      color: _isFocusedVname
                          ? Colors.blueAccent.shade400
                          : Colors.grey.shade600,
                    ),
                    hintText: "Model name",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade600, fontSize: 14),
                    filled: true,
                    fillColor: _isFocusedVname
                        ? Colors.blueAccent.shade200.withOpacity(0.2)
                        : Colors.grey.shade600.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: _isFocusedVname
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
                  onChanged: (value) {
                    setState(() {
                      _vehicleModel = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                height: 50,
                child: TextField(
                  controller: _platenum,
                  focusNode: _vNumberFocusNode,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.padding_rounded,
                      color: _isFocusedVnumber
                          ? Colors.blueAccent.shade400
                          : Colors.grey.shade600,
                    ),
                    hintText: "Plate number",
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade600, fontSize: 14),
                    filled: true,
                    fillColor: _isFocusedVnumber
                        ? Colors.blueAccent.shade200.withOpacity(0.2)
                        : Colors.grey.shade600.withOpacity(0.2),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        width: 2.0,
                        color: _isFocusedVnumber
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
                  onChanged: (value) {
                    setState(() {
                      _vehicleNumber = value;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),
                child: ElevatedButton(
                  onPressed: (_vehicleModel.isNotEmpty &&
                      _vehicleNumber.isNotEmpty)
                      ? () {
                    setState(() {
                      mainfireid = fireid.toString();
                    });
                    _createNewcar();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green.shade100,
                        duration: const Duration(seconds: 3),
                        showCloseIcon: true,
                        closeIconColor: Colors.white,
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              'Vehicle Added',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'New Vehicle has been registered',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.green.shade400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                    // Create the new vehicle object
                    // Vehicle newVehicle = Vehicle(
                    //     name: _vehicleModel, numberPlate: _vehicleNumber);
                    //
                    // // Return the new vehicle to the previous screen
                    // Get.back(result: newVehicle);

                  }
                      : () {
                    // Show error Snackbar if any of the fields is empty
                    if (_vehicleModel.isEmpty) {
                      setState(() {
                        count =1;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade100,
                          duration: const Duration(seconds: 3),
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
                                'Enter a Valid Vehicle Name',
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
                    if (_vehicleNumber.isEmpty && count!=1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red.shade100,
                          duration: const Duration(seconds: 3),
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
                                'Enter a Valid Vehicle Number',
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
                  },
                  child: Text(
                    'Add Vehicle',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueAccent.shade700,
                    elevation: 9,
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
    _vNameFocusNode.addListener(_handleVnameFocusChange);
    _vNumberFocusNode.addListener(_handleVnumberFocusChange);
  }

  @override
  void dispose() {
    _vNameFocusNode.removeListener(_handleVnameFocusChange);
    _vNumberFocusNode.removeListener(_handleVnumberFocusChange);
    super.dispose();
  }

  void _handleVnameFocusChange() {
    if (_vNameFocusNode.hasFocus != _isFocusedVname) {
      setState(() {
        _isFocusedVname = _vNameFocusNode.hasFocus;
      });
    }
  }

  void _handleVnumberFocusChange() {
    if (_vNumberFocusNode.hasFocus != _isFocusedVnumber) {
      setState(() {
        _isFocusedVnumber = _vNumberFocusNode.hasFocus;
      });
    }
  }
}
