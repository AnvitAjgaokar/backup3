
import  'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/parkingspot.dart';
import 'package:sem5demo3/searchpage.dart';
import 'package:sem5demo3/selectvehicle.dart';

import 'package:table_calendar/table_calendar.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key}) : super(key: key);

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  DateTime _selectedDate = DateTime.now();
  double _selectedDuration = 1.0;
  String _startTimeText = '';
  String _endTimeText = '';
  int _totalcost = 80;
  dynamic _maintotal;
  dynamic _ratemain;

  Future<void> _selectStartTime() async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      setState(() {
        _startTimeText = selectedTime.format(context);
        // Update the end time as well based on the selected duration
        _endTimeText = TimeOfDay.fromDateTime(
          DateTime.now().add(
            Duration(hours: _selectedDuration.toInt()),
          ),
        ).format(context);
      });
    }
  }


  void _onDaySelected(DateTime day, DateTime focusDay) {
    setState(() {
      _selectedDate = day;
    });
  }

  void _onDurationChanged(double value) {
    setState(() {
      _selectedDuration = value;
      // Calculate and assign formatted end time to _endTimeText
      _startTimeText = TimeOfDay.now().format(context);
      _endTimeText = TimeOfDay.fromDateTime(
              DateTime.now().add(Duration(hours: _selectedDuration.toInt())))
          .format(context);
    });
  }

  Future<void> _createParkingdetail() async {
    print("Creating Details");

// Convert the resized image to base64

    final String createDetailMutation = '''
      mutation () {
        createParkingdetail(selecteddate: "${_selectedDate.toString()}", duration: "${_selectedDuration.toString()}", starthour: "${_startTimeText.toString()}", endhour: "${_endTimeText.toString()}", totalcost: ${_totalcost.toInt()}) {
          parkingdetail {
            id
            selecteddate
            duration
            starthour
            endhour
            totalcost

          }
        }
      }
    ''';

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createDetailMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating Details: ${result.exception.toString()}');
    } else {
      print('Details created successfully!');
      // Clear form fields after successful user creation
    }
  }

  final String getRateQuery = r'''
    query ($id: ID!){
      parkingspotbyid(id: $id) {
        rate
      }
    }
  ''';

  Future<void> _updateParkdetails() async {
    print("Updating details!!");
    final String updateDetailMutation = '''
      mutation() {
        updateParkdetails(inputData: {
          detailId: "${SelectVehicle.maindetailiddd.toString()}"
          selecteddate: "${_selectedDateText.toString()}",
          duration: "${_selectedDuration.toString()}"
          starthour: "${_startTimeText.toString()}"
          endhour: "${_endTimeText.toString()}"
          totalcost: "${_maintotal.toString()}"
          
    
        }) {
          detail {
            id
            selecteddate
            duration
            starthour
            endhour
            totalcost

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

  Map<String, dynamic> ratelist = {};
  String _selectedDateText = ''; // Add this line at the top of your class






  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    final DateTime today = DateTime.now();
    final DateTime nextTwoDays = today.add(Duration(days: 2));


    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Book Parking Details',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20),
          ),
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {
              // AuthenticationRepository.insatnce.logout();
              // FirebaseAuth.instance.signOut();
              // Get.offAll(() => SignUpFormWidget(),
              //     transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
              // Go back when the back button is pressed
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Select Date",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                // height: 200,
                margin: const EdgeInsets.all(15), // Add margin for spacing
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Rounded borders
                  color: Colors.blueAccent.shade100
                      .withOpacity(0.1), // Blue background color
                ),
                child: TableCalendar(
                  focusedDay: _selectedDate,
                  firstDay: today, // Restrict to today
                  lastDay: nextTwoDays,
                  // firstDay: DateTime.utc(2023, 1, 1),
                  // lastDay: DateTime.utc(2023, 12, 31),
                  pageAnimationEnabled: true,
                  rowHeight: 35,
                  calendarStyle: CalendarStyle(
                    selectedDecoration: BoxDecoration(
                        color: Colors.blueAccent.shade700,
                        shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(
                        color: Colors.blueAccent.shade100,
                        shape: BoxShape.circle),
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 16),
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
                  onDaySelected: _onDaySelected,
                ),
              ),
              const SizedBox(height: 10),


              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: [
                    Text(
                      'Select Start Hour',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      width: 110,
                    ),
                    Text(
                      'End Hour',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: _selectStartTime,
                      child: Container(
                        height: 40,
                        width: 120,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // Rounded borders
                            color: Colors.grey.shade300 // Blue background color
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _startTimeText,
                              style: GoogleFonts.poppins(),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.black54,
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 40,
                      width: 120,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5), // Rounded borders
                        color: Colors.grey.shade300, // Blue background color
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${_endTimeText}",
                            style: GoogleFonts.poppins(),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.watch_later_outlined,
                            color: Colors.black54,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Select Duration",
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: Colors.blueAccent.shade700,
                        inactiveTrackColor: Colors.grey.shade500,
                        thumbColor: Colors.blueAccent.shade200,
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
                        overlayColor: Colors.blueAccent.shade100,
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 15),
                        tickMarkShape: const RoundSliderTickMarkShape(),
                        activeTickMarkColor: Colors.blueAccent.shade700,
                        inactiveTickMarkColor: Colors.grey.shade500,
                        valueIndicatorShape: const PaddleSliderValueIndicatorShape(),
                        valueIndicatorColor: Colors.blueAccent.shade700,
                        valueIndicatorTextStyle: const TextStyle(color: Colors.white),
                      ),
                      child: Slider(
                        value: _selectedDuration,
                        onChanged: _onDurationChanged,
                        min: 0,
                        max: 12,
                        divisions: 12,
                        label: "${_selectedDuration.round()} hours",
                      ),
                    ),
                  ],
                ),
              ),


              const SizedBox(
                height: 10,
              ),
               Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    'Total',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Query(
                      options: QueryOptions(
                        document: gql(getRateQuery),
                        variables: {'id' :1 },
                      ),
                      builder: (QueryResult result, {fetchMore, refetch}) {
                        if (result.hasException) {
                          print(result.exception.toString());
                          return Center(
                            child: Text(
                                'Error fetching Rate: ${result.exception.toString()}'),
                          );
                        }

                        if (result.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        ratelist = result.data?['parkingspotbyid'] ?? [];
                        dynamic _rate  = ratelist['rate'];
                        _ratemain = _rate;

                        return Text(
                          "₹${_rate* _selectedDuration.round()}",
                          style: GoogleFonts.poppins(
                              color: Colors.blueAccent.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        );
                      },

                    ),
                    const SizedBox(
                      width: 2,
                    ),
                    Text(
                      '/ ${_selectedDuration.round()} hour',
                      style: GoogleFonts.poppins(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    )
                  ],
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
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _maintotal = _ratemain*_selectedDuration.toInt();
          
                    });
                    _selectedDateText = DateFormat('dd-MM-yyyy').format(_selectedDate);

                    // _createParkingdetail();
                    _updateParkdetails();
                    Get.to(() => ParkingSpotSelection(),
                        transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
                    print('The Rate is $ratelist');
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    backgroundColor: Colors.blueAccent.shade700,
                    elevation: 9,
                  ),
                  child: Text(
                    'Continue Booking',
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
}
