import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sem5demo3/addvehicle.dart';
import 'package:sem5demo3/animations/loading%20animation.dart';
import 'package:sem5demo3/bookingdetail.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/parkobject.dart';
import 'package:sizer/sizer.dart';

class SelectVehicle extends StatefulWidget {
  static String maindetailiddd = '';
  const SelectVehicle({Key? key}) : super(key: key);

  @override
  State<SelectVehicle> createState() => _SelectVehicleState();
}

class _SelectVehicleState extends State<SelectVehicle> {

  final String getVehicleQuery = r'''
    query($fireid: String!) {
      vehiclesbyfireid(fireid: $fireid) {
        id
        modelname
        platenum
        

      }
    }
  ''';

  dynamic maindetailid =0;

  FirebaseAuth auth = FirebaseAuth.instance;
  List<dynamic> dataList = [];
  dynamic modelname;
  dynamic platnum;
  int selectedIndex = -1; // Store the selected tile index

  final String getDetailidQuery = r'''
    query($fireid: String!, $todaydate: String!, $parkingname: String!) {
      parkingdetailbymulti(fireid: $fireid, todaydate: $todaydate, parkingname: $parkingname) {
        id
      }
    }
  ''';

  List<dynamic> iddatalist =[];
  // Map<String,dynamic> iddata = {};

  DateTime now = DateTime.now();
  dynamic mainnow;
  List<String> idList = [];

  Future<void> _updateParkdetails() async {
    print("Updating details!!");
    final String updateDetailMutation = '''
      mutation() {
        updateParkdetails(inputData: {
          detailId: "${maindetailid}"
          username: "${mainuser.toString()}"
          phoneno: "${mainphone.toString()}"
          vehiclename: "${modelname.toString()}",
          vehiclenum: "${platnum.toString()}"
    
        }) {
          detail {
            id
            username
            phoneno
            vehiclename
            vehiclenum

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

  final String userDeatil = r'''
    query ($fireid: String!){
      usersbyfireid(fireid: $fireid) {
        username
        phoneno
      }
    }
  ''';

  Map<String, dynamic> newdatalist = {};

  dynamic mainuser;
  dynamic mainphone;




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
            'Select Vehicle',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20),
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

        body: Query(options: QueryOptions(
          document: gql(getVehicleQuery),
          // variables: {'id': NewAcountone.idvaluee},
          variables: {'fireid': fireid},

        ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Center(
                child: Text(
                    'Error fetching vehicle: ${result.exception.toString()}'),
              );
            }

            if (result.isLoading) {
              return LoadingPageOne();
            }

            dataList = result.data?['vehiclesbyfireid'] ?? [];
            // dynamic _username  = dataList['username'];

            // if (dataList.isEmpty) {
            //   return Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         SvgPicture.asset(
            //           "assets/images/search_list_svg.svg", height: 200,
            //           width: 200,),
            //         SizedBox(height: 10,),
            //         Text("There are no Saved Parking Lots",
            //           style: GoogleFonts.poppins(fontSize: 15),)
            //
            //       ],
            //     ),
            //   );
            // }


            return Column(
                children: [
                  SizedBox(height: 4.0.h,),
                  Container(
                    height: 55.0.h,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: dataList.length,
                      // itemCount: filteredDataList.length,
                      itemBuilder: (context, index) {
                        final vehicle = dataList[index];
                        final vehicleid = vehicle['id'];
                        final fireid = vehicle['fireid'];
                        final isSelected = index == selectedIndex;

                        // final item = filteredDataList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            elevation: 9, // Add elevation to the Card
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(
                                  width: 0.3.h,
                                  color: isSelected ? Colors.blueAccent.shade700 : Colors.transparent,
                                )
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              title: Text(
                                '${vehicle['modelname']}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              subtitle: Text(
                                '${vehicle['platenum']}',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              leading: Image.asset(
                                'assets/images/selectcar.jpg',
                                width: 18.0.w,
                                height: 15.0.h,
                              ),
                              trailing: IconButton(icon: Icon(Icons.check_circle,
                                color: isSelected ? Colors.blueAccent.shade700 : Colors.grey.shade400,
                              ), onPressed: () {
                                setState(() {
                                  selectedIndex = isSelected ? -1 : index;
                                  modelname = vehicle['modelname'];
                                  platnum = vehicle['platenum'];// Toggle selection
                                  mainnow = formattedDate.toString();
                                  for (var data in iddatalist) {
                                    String id = data['id'];
                                    idList.add(id);
                                  }

                                  maindetailid = idList.isNotEmpty ? idList.last : '';
                                  SelectVehicle.maindetailiddd = maindetailid;
                                  // print('mainid: ${maindetailid}');

                                  print( '${iddatalist}');
                                });

                              },),
                              onTap: () {

                              },
                            ),
                          ),
                        );
                      },
                    ),),

                  SizedBox(height: 15,),

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

                  SizedBox(height: 7.0.h,),

                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        _updateParkdetails();
                        Get.to(() => BookingDetails(),
                            transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
                      },
                      child: Text(
                        'Continue Booking',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.blueAccent.shade700,
                        elevation: 9,
                      ),
                    ),
                  ),

                  Query(
                    options: QueryOptions(
                      document: gql(getDetailidQuery),
                      // variables: {'id' :NewAcountone.idvaluee },
                      variables: {'fireid': fireid, 'todaydate': mainnow.toString(), 'parkingname':ParkingOne.nameee.toString()},

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
                            color: Colors.transparent,
                            backgroundColor: Colors.transparent,
                          ),
                        );
                      }

                      iddatalist = result.data?['parkingdetailbymulti'] ?? [];

                      return Visibility(
                          visible: false,
                          child: Text(
                            "",
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w300,
                                fontSize: 16,
                                color: Colors.black),
                          ));
                    },

                  ),

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

                      newdatalist = result.data?['usersbyfireid'] ?? [];
                      mainuser = newdatalist['username'];
                      mainphone = newdatalist['phoneno'];


                      return Visibility(visible: false,child: Text("",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),));
                    },

                  ),


                ]

            );
          },
        ),

      ),
    );
  }
}