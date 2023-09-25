
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/selectvehicle.dart';
import 'package:sem5demo3/summary.dart';
import 'package:sem5demo3/ticket.dart';

import 'client.dart';

class ParkingSpotSelection extends StatefulWidget {
  static String floorv = 'Floor 1';
  static String spotv = '';
  @override
  _ParkingSpotSelectionState createState() => _ParkingSpotSelectionState();
}

class _ParkingSpotSelectionState extends State<ParkingSpotSelection> {
  // int _selectedButtonIndex = -1; // Index of the selected button
  int _selectedSpotIndex = -1; // Index of the selected spot
  bool _isfloorselected = false;
  bool _isspotselected = false;
  int _selectedButtonIndex = 0;

  String _selectedFloorValue = ''; // Variable to store the selected floor
  String _selectedSpotValue = '';

  Future<void> _updateParkdetails() async {
    print("Updating details!!");
    final String updateDetailMutation = '''
      mutation() {
        updateParkdetails(inputData: {
          detailId: "${SelectVehicle.maindetailiddd.toString()}"
          floornum: "${ParkingSpotSelection.floorv.toString()}",
          spotnum: "${ParkingSpotSelection.spotv.toString()}"
    
        }) {
          detail {
            id
            floornum
            spotnum

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
      document: gql(updateDetailMutation),
      // variables: {'id': userId},
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error updating Details: ${result.exception.toString()}');
    } else {
      print('Details updated successfully');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Pick Parking Spot',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 20,
            ),
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
        body: Column(
          children: [
            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Container(
                child: SingleChildScrollView(
                  child: OutlinedButtonRow(
                    buttonTexts: const ['Floor 1', 'Floor 2', 'Floor 3'],
                    onPressed: (index) {
                      setState(() {
                        _selectedButtonIndex = index;
                        _selectedSpotIndex = -1;
                        _isfloorselected = true; // Reset spot selection
                      });
                    },
                    selectedIndex: _selectedButtonIndex,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(
              height: 10,
              color: Colors.grey.shade200,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Container(
                height: 450,
                child: SingleChildScrollView(
                  child: Column(children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Stack(children: [
                      Row(
                          children: [
                            Column(
                                children: [
                                  Text(
                                    "Entry",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  // Text(
                                  //   "↓",
                                  //   style: GoogleFonts.poppins(fontSize: 30),
                                  // ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "↓",
                                    style: GoogleFonts.poppins(fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]),

                            SizedBox(width: 270,),

                            Column(
                                verticalDirection: VerticalDirection.up,
                                children: [
                                  Text(
                                    "Exit",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  // Text(
                                  //   "↓",
                                  //   style: GoogleFonts.poppins(fontSize: 30),
                                  // ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "│",
                                    style: GoogleFonts.poppins(fontSize: 25),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),

                                  Text(
                                    "↑",
                                    style: GoogleFonts.poppins(fontSize: 30),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ]),
                          ]
                      ),

                      SizedBox(width: 20,),

                      Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: OutlinedParkingspot(
                          buttonTextsA: const [
                            'A101',
                            'A102',
                            'NA',
                            'A104',
                            'NA',
                            'A106'
                          ],
                          buttonTextsB: const [
                            'NA',
                            'B102',
                            'NA',
                            'NA',
                            'B105',
                            'NA',
                          ],
                          buttonTextsC: const [
                            'C101',
                            'C102',
                            'C103',
                            'C104',
                            'C105',
                            'NA',
                          ],
                          onPressed: () {
                            setState(() {
                              _isspotselected = true;
                              print('The value is:${_isspotselected}');
                            });

                          },
                        ),
                      ),


                      // SizedBox(width: 2,),
                    ]),
                  ]),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 10,
              color: Colors.grey.shade200,
              thickness: 2,
            ),
            const SizedBox(
              height: 20,
            ),
            Visibility(
              visible: true,
              child: Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    // print("Floor ${ParkingSpotSelection.floorv}\nspotval ${ParkingSpotSelection.spotv}");
                    if (ParkingSpotSelection.spotv == 'NA'){
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
                                'Unavailable!!',

                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'The Spot is Already Booked',
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
                      _updateParkdetails();
                      Get.to(SummaryPage());

                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueAccent.shade700,
                    elevation: 9,
                  ),
                  child: Text(
                    'Continue to Pay',
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

class OutlinedButtonRow extends StatelessWidget {
  final List<String> buttonTexts;
  final ValueChanged<int>? onPressed;
  final int? selectedIndex;
  String _floorvalue = '';


  OutlinedButtonRow(
      {required this.buttonTexts, this.onPressed, this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    List<Widget> currentRow = [];


    for (int i = 0; i < buttonTexts.length; i++) {
      bool isSelected = i == selectedIndex;

      currentRow.add(Container(
        margin: const EdgeInsets.symmetric(horizontal: 3.0),
        child: OutlinedButton(
          onPressed: () {
            if (onPressed != null) onPressed!(i);
            _floorvalue = buttonTexts[i];
            ParkingSpotSelection.floorv = buttonTexts[i];

          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: Colors.blueAccent.shade700),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            backgroundColor:
            isSelected ? Colors.blueAccent.shade700 : Colors.transparent,
          ),
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: Text(
              buttonTexts[i],
              style: GoogleFonts.poppins(
                color: isSelected ? Colors.white : Colors.blueAccent.shade700,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ));

      if (currentRow.length == 3 || i == buttonTexts.length - 1) {
        rows.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: currentRow,
        ));

        currentRow = [];
      }
    }

    return Column(
      children: rows,
    );
  }
}
class OutlinedParkingspot extends StatefulWidget {
  final List<String> buttonTextsA;
  final List<String> buttonTextsB;
  final List<String> buttonTextsC;
  final VoidCallback? onPressed;
  final int? selectedIndex;
  String _spotvalue = '';

  OutlinedParkingspot({
    required this.buttonTextsA,
    required this.buttonTextsB,
    required this.buttonTextsC,
    this.selectedIndex,
    this.onPressed,
  });

  @override
  _OutlinedParkingspotState createState() => _OutlinedParkingspotState();
}

class _OutlinedParkingspotState extends State<OutlinedParkingspot> {
  int _selectedButtonIndexA = -1; // Index of the selected button in A
  int _selectedButtonIndexB = -1; // Index of the selected button in B
  int _selectedButtonIndexC = -1; // Index of the selected button in C
  String _selectedSpotValue = ''; // Store the selected spot value

  @override
  Widget build(BuildContext context) {
    List<Widget> rowsA = [];
    List<Widget> rowsB = [];
    List<Widget> rowsC = [];

    List<Widget> currentRowA = [];
    List<Widget> currentRowB = [];
    List<Widget> currentRowC = [];

    for (int i = 0; i < widget.buttonTextsA.length; i++) {
      bool isSelectedA = i == _selectedButtonIndexA;
      bool isSelectedB = i == _selectedButtonIndexB;
      bool isSelectedC = i == _selectedButtonIndexC;

      currentRowA.add(
        Container(
          width: 90,
          margin: const EdgeInsets.only(left: 3, right: 3),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedButtonIndexA = i;
                _selectedButtonIndexB = -1;
                _selectedButtonIndexC = -1;
                _selectedSpotValue = widget.buttonTextsA[i];
                ParkingSpotSelection.spotv = widget.buttonTextsA[i];
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blueAccent.shade700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor:
              isSelectedA ? Colors.blueAccent.shade700 : Colors.transparent,
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                widget.buttonTextsA[i],
                style: GoogleFonts.poppins(
                  color:
                  isSelectedA ? Colors.white : Colors.blueAccent.shade700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );

      // Similar implementation for list B
      // ...

      if (currentRowA.length == 2 || i == widget.buttonTextsA.length - 1) {
        rowsA.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: currentRowA,
          ),
        );

        currentRowA = [];
      }

      // ... (similar loops for rowsB and rowsC)


      currentRowB.add(
        Container(
          width: 90,
          margin: const EdgeInsets.only(left: 3, right: 3),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedButtonIndexA = -1;
                _selectedButtonIndexB = i;
                _selectedButtonIndexC = -1;
                _selectedSpotValue = widget.buttonTextsB[i];
                ParkingSpotSelection.spotv = widget.buttonTextsB[i];
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blueAccent.shade700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor:
              isSelectedB ? Colors.blueAccent.shade700 : Colors.transparent,
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                widget.buttonTextsB[i],
                style: GoogleFonts.poppins(
                  color:
                  isSelectedB ? Colors.white : Colors.blueAccent.shade700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );

      // Similar implementation for list B
      // ...

      if (currentRowB.length == 2 || i == widget.buttonTextsB.length - 1) {
        rowsB.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: currentRowB,
          ),
        );

        currentRowB = [];
      }



      currentRowC.add(
        Container(
          width: 90,
          margin: const EdgeInsets.only(left: 3, right: 3),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedButtonIndexA = -1;
                _selectedButtonIndexB = -1;
                _selectedButtonIndexC = i;
                _selectedSpotValue = widget.buttonTextsC[i];
                ParkingSpotSelection.spotv = widget.buttonTextsC[i];
              });
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: Colors.blueAccent.shade700),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              backgroundColor:
              isSelectedC ? Colors.blueAccent.shade700 : Colors.transparent,
            ),
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(
                widget.buttonTextsC[i],
                style: GoogleFonts.poppins(
                  color:
                  isSelectedC ? Colors.white : Colors.blueAccent.shade700,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ),
      );

      // Similar implementation for list B
      // ...

      if (currentRowC.length == 2 || i == widget.buttonTextsC.length - 1) {
        rowsC.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: currentRowC,
          ),
        );

        currentRowC = [];
      }
    }

    return Column(
      children: [
        Text(
          'Section A',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...rowsA,

        SizedBox(height: 10),

        Text(
          'Section B',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...rowsB,

        SizedBox(height: 10),

        Text(
          'Section C',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        ...rowsC,


        // ... (similar implementation for sections B and C)
      ],
    );
  }
}

