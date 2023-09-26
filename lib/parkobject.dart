import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/selectvehicle.dart';
import 'package:dots_indicator/dots_indicator.dart';

class ParkingOne extends StatefulWidget {
  static String nameee = '';
  const ParkingOne({Key? key}) : super(key: key);

  @override
  State<ParkingOne> createState() => _ParkingOneState();
}

class _ParkingOneState extends State<ParkingOne> {
  int _currentPageIndex = 0;
  bool _isSaved = false;

  dynamic _name;
  dynamic _address;


  Future<void> _createDetails() async {
    print("Creating Parking Details");

// Convert the resized image to base64

    final String createDetailtMutation = '''
      mutation () {
        createParkingdetail(fireid: "${mainfireid.toString()}", todaydate: "${mainnow.toString()}", parkingname: "${_name.toString()}", address: "${_address.toString()}") {
          parkingdetail {
            id
            fireid
            parkingname
            address
     

          }
        }
      }
    ''';

    final GraphQLClient _client = client.value;

    final MutationOptions options = MutationOptions(
      document: gql(createDetailtMutation),
    );

    final QueryResult result = await _client.mutate(options);

    if (result.hasException) {
      print('Error creating Details: ${result.exception.toString()}');
    } else {
      print('Details created successfully!');
      // Clear form fields after successful user creation

    }
  }

  Future<void> _deleteSaved(String userId) async {
    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final MutationOptions options = MutationOptions(
      document: gql(deleteSavedMutation),
      variables: {'id': userId},
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error deleting Saved: ${result.exception.toString()}');
    } else {
      final success = result.data?['deleteSaved']['success'];
      if (success) {

        print('Saved deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.yellow.shade100,
            duration: const Duration(seconds: 6),
            showCloseIcon: true,
            closeIconColor: Colors.white,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  'Removed from Saved',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_name.toString()} has been removed from Saved',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.yellow.shade400,
                  ),
                ),
              ],
            ),
          ),
        );
      } else {
        print('Failed to delete Saved');
      }
    }
  }

  final String deleteSavedMutation = r'''
    mutation($id: ID!) {
      deleteSaved(id: $id) {
        success
      }
    }
  ''';


  List imageUrls = [
    'assets/images/parkone4svg.svg',
    // 'assets/images/parkone4svg.svg',
    // 'assets/images/parkone4svg.svg',
    // 'assets/images/parkone4svg.svg',

  ];

  final String parkingSpotDeatil = r'''
    query ($id: ID!){
      parkingspotbyid(id: $id) {
        name
        address
        distance
        time
        valet
        description
        rate
      }
    }
  ''';

  FirebaseAuth auth = FirebaseAuth.instance;

  dynamic mainfireid;


  Map<String, dynamic> datalist = {};

  Future<void> _createSaved() async {
    print("Creating Saved");

// Convert the resized image to base64

    final String createWalletMutation = '''
      mutation () {
        createSaved(fireid:"${mainfireid}",spotname:"${_name.toString()}", spotaddress: "${_address.toString()}") {
          save {
            id
            spotname
            spotaddress
     

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
                'Saved Successfully!',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${_name.toString()} has been added to Saved',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.green.shade400,
                ),
              ),
            ],
          ),
        ),
      );
      // Clear form fields after successful user creation

    }
  }
  // FirebaseAuth auth = FirebaseAuth.instance;
  // String mainfireid = '';

  DateTime now = DateTime.now();
  dynamic mainnow;

  // Format the date as 'DD-MM-YYYY'



  @override
  Widget build(BuildContext context) {
    String fireid = auth.currentUser!.uid.toString();
    String formattedDate = DateFormat('dd-MM-yyyy').format(now);


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
            'Parking Details',
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
          ),
          leading: IconButton(
            padding: const EdgeInsets.only(left: 15),
            onPressed: () {
              // Navigator.pop(context); // Go back when the back button is pressed
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          bottomOpacity: 0,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 15,
              ),
              // Image slider with dots indicator
              Stack(
                children: [
                  Container(
                    height: 170,
                    child: PageView.builder(
                      // allowImplicitScrolling: true,
                      // controller: _pageController,
                      itemCount: imageUrls.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: SvgPicture.asset(
                              imageUrls[index],
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                      onPageChanged: (int index) {
                        setState(() {
                          _currentPageIndex = index;
                        });
                      },
                    ),
                  ),
                  // Positioned(
                  //   bottom: 10.0,
                  //   left: 0.0,
                  //   right: 0.0,
                  //   child: DotsIndicator(
                  //     dotsCount: imageUrls.length,
                  //     position: _currentPageIndex.toDouble(),
                  //     decorator: DotsDecorator(
                  //       activeColor: Colors.blueAccent.shade700,
                  //       color: Colors.white,
                  //       activeShape: const RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.horizontal(
                  //           left: Radius.circular(5.0),
                  //           // Adjust the left radius to elongate the active dot
                  //           right: Radius.circular(
                  //               5.0), // Adjust the right radius to elongate the active dot
                  //         ),
                  //       ),
                  //       activeSize: const Size(30.0,
                  //           8.0), // Adjust the size to elongate the active dot
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              // Rest of the content...
              // Name of the parking lot and save button
              ListTile(
                title:Query(
                  options: QueryOptions(
                    document: gql(parkingSpotDeatil),
                    variables: {'id': 1},
                  ),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print(result.exception.toString());
                      return Center(
                        child: Text(
                            'Error fetching name: ${result.exception.toString()}'),
                      );
                    }

                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 0.1,
                          color: Colors.transparent,
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    }

                    datalist = result.data?['parkingspotbyid'] ?? [];
                    _name  = datalist['name'];


                    return Text(
                      '${_name}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black),
                    );
                  },

                ),//Text(
                //   widget.lotName,
                //   style: GoogleFonts.poppins(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 22,
                //       color: Colors.black),
                // ),
                subtitle: Query(
                  options: QueryOptions(
                    document: gql(parkingSpotDeatil),
                    variables: {'id': 1},
                  ),
                  builder: (QueryResult result, {fetchMore, refetch}) {
                    if (result.hasException) {
                      print(result.exception.toString());
                      return Center(
                        child: Text(
                            'Error fetching addresss: ${result.exception.toString()}'),
                      );
                    }

                    if (result.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 0.1,
                          color: Colors.transparent,
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    }

                    datalist = result.data?['parkingspotbyid'] ?? [];
                    _address  = datalist['address'];


                    return Text(
                      '${_address}',
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black45),
                    );
                  },

                ),//Text(
                //   widget.subtitle,
                //   style: GoogleFonts.poppins(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 14,
                //       color: Colors.black45),
                // ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      _isSaved = !_isSaved;
                      mainfireid = fireid;// Toggle the saved state
                    });
                    if (_isSaved){
                      _createSaved();
                    }

                    if (_isSaved==false){
                      // _deleteSaved(id.toString());
                    }
                    print("Date: ${now}");
                  },
                  icon: Icon(
                    _isSaved ? Icons.bookmark : Icons.bookmark_border,
                    color: _isSaved
                        ? Colors.blueAccent.shade700
                        : Colors.grey, // Change color based on the saved state
                  ),
                ),
              ),

              // Three boxes in a row for time, distance, and valet availability
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // InfoBox(icon: Icons.location_pin, value: widget.time),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent.shade700),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.blueAccent.shade700,
                        ),
                        const SizedBox(width: 5),
                        Query(
                          options: QueryOptions(
                            document: gql(parkingSpotDeatil),
                            variables: {'id': 1},
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print(result.exception.toString());
                              return Center(
                                child: Text(
                                    'Error fetching time: ${result.exception.toString()}'),
                              );
                            }

                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 0.1,
                                  color: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }

                            datalist = result.data?['parkingspotbyid'] ?? [];
                            dynamic _distance  = datalist['distance'];

                            return Text(
                              '${_distance}',
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent.shade700),
                            );
                          },

                        )

                      ],
                    ),
                  ),
                  // InfoBox(
                  //     icon: Icons.watch_later_rounded, value: widget.distance),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent.shade700),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.watch_later_rounded,
                          color: Colors.blueAccent.shade700,
                        ),
                        const SizedBox(width: 5),
                        Query(
                          options: QueryOptions(
                            document: gql(parkingSpotDeatil),
                            variables: {'id': 1},
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print(result.exception.toString());
                              return Center(
                                child: Text(
                                    'Error fetching Distance: ${result.exception.toString()}'),
                              );
                            }

                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 0.1,
                                  color: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }

                            datalist = result.data?['parkingspotbyid'] ?? [];
                            dynamic _time  = datalist['time'];



                            return Text(
                              '${_time}',
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent.shade700),
                            );
                          },

                        )

                      ],
                    ),
                  ),
                  // InfoBox(
                  //     icon: Icons.person_rounded,
                  //     value: widget.valetAvailability),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent.shade700),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_rounded,
                          color: Colors.blueAccent.shade700,
                        ),
                        const SizedBox(width: 5),
                        Query(
                          options: QueryOptions(
                            document: gql(parkingSpotDeatil),
                            variables: {'id': 1},
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print(result.exception.toString());
                              return Center(
                                child: Text(
                                    'Error fetching Valet: ${result.exception.toString()}'),
                              );
                            }

                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 0.1,
                                  color: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }

                            datalist = result.data?['parkingspotbyid'] ?? [];
                            dynamic _valet  = datalist['valet'];

                            return Text(
                              '${_valet}',
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent.shade700),
                            );
                          },

                        )

                      ],
                    ),
                  ),
                ],
              ),

              const Divider(
                height: 5,
                color: Colors.white38,
                thickness: 5,
              ),

              // Description of the parking lot
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    // Add some spacing between the title and description
                    Container(
                      height: 110,
                      child: SingleChildScrollView(
                        child: Query(
                          options: QueryOptions(
                            document: gql(parkingSpotDeatil),
                            variables: {'id': 1},
                          ),
                          builder: (QueryResult result, {fetchMore, refetch}) {
                            if (result.hasException) {
                              print(result.exception.toString());
                              return Center(
                                child: Text(
                                    'Error fetching description: ${result.exception.toString()}'),
                              );
                            }

                            if (result.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 0.1,
                                  color: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }

                            datalist = result.data?['parkingspotbyid'] ?? [];
                            dynamic _description  = datalist['description'];


                            return Text(
                              '${_description}',
                              style: GoogleFonts.poppins(
                                  fontSize: 15.0, color: Colors.black45),
                            );
                          },

                        )
                      ),
                    ),
                  ],
                ),
              ),

              // Rectangle to display price
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Container(
                    height: 90,
                    padding: const EdgeInsets.only(
                        top: 12, bottom: 16, left: 10, right: 16),
                    // Add horizontal padding
                    color: Colors.blueAccent.shade100.withOpacity(0.2),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Query(
                          options: QueryOptions(
                            document: gql(parkingSpotDeatil),
                            variables: {'id': 1},
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
                                child: CircularProgressIndicator(
                                  strokeWidth: 0.1,
                                  color: Colors.transparent,
                                  backgroundColor: Colors.transparent,
                                ),
                              );
                            }

                            datalist = result.data?['parkingspotbyid'] ?? [];
                            dynamic _rate  = datalist['rate'];


                            return Text(
                              '₹${_rate}',
                              style: GoogleFonts.poppins(
                                  color: Colors.blueAccent.shade700,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            );
                          },

                        ),
                        Text(
                          'per hour',
                          style: GoogleFonts.poppins(
                              color: Colors.black38, fontSize: 14),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 15,
              ),
              Divider(
                height: 10,
                color: Colors.grey.shade200,
                thickness: 2,
              ),

              const SizedBox(
                height: 15,
              ),

              // Book and Cancel buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 180,
                    height: 45,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.poppins(
                            fontSize: 15, color: Colors.blueAccent.shade700),
                      ),
                      style: ElevatedButton.styleFrom(
                          shape: const StadiumBorder(),
                          backgroundColor:
                              Colors.blueAccent.shade200.withOpacity(0.2),
                          elevation: 0),
                    ),
                  ),
                  Container(
                    width: 180,
                    height: 45,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => const SelectVehicle(),
                            transition: Transition.cupertinoDialog,
                            duration: const Duration(seconds: 1));
                        setState(() {
                          mainfireid = fireid;
                          mainnow= formattedDate.toString();
                          ParkingOne.nameee = _name;
                        });
                        _createDetails();
                      },
                      child: Text(
                        'Book Parking',
                        style: GoogleFonts.poppins(
                            fontSize: 13, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        backgroundColor: Colors.blueAccent.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class InfoBox extends StatelessWidget {
  final IconData icon;
  final String value;

  const InfoBox({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent.shade700),
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blueAccent.shade700,
          ),
          const SizedBox(width: 5),
          Text(
            value,
            style: GoogleFonts.poppins(color: Colors.blueAccent.shade700),
          ),
        ],
      ),
    );
  }
}

