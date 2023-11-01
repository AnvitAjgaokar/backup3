import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sem5demo3/parkingpage/ongoing.dart';
import 'package:sizer/sizer.dart';
import 'package:qr_flutter/qr_flutter.dart';


import 'client.dart';

class ParkingTicket extends StatefulWidget {
  const ParkingTicket({Key? key}) : super(key: key);

  @override
  State<ParkingTicket> createState() => _ParkingTicketState();
}

class _ParkingTicketState extends State<ParkingTicket> {
  final String getTicketDetails = r'''
    query ($id: ID!){
      parkingspotbyid(id: $id) {
        rate
      }
    }
  ''';

  final String parkingDeatil = r'''
    query ($id: String!){
      parkingdetailbyid(id: $id) {
          id
          parkingname
          address
          vehiclename
          vehiclenum
          floornum
          spotnum
          selecteddate
          starthour
          endhour
          duration
          totalcost
      }
    }
  ''';

  Map<String, dynamic> datalist = {};
  FirebaseAuth auth = FirebaseAuth.instance;

  dynamic qrname;




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
            'Parking Ticket',
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QrImage(
                data: "$qrname",
                version: QrVersions.auto,
                errorCorrectionLevel: QrErrorCorrectLevel.H,
                size: 160,
              ),
              SizedBox(height: 15,),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 120),

                child: Card(

                  elevation: 9,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 3.0.h,),
                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [


                            Text("ParkingLot",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,

                                )),
                            SizedBox(
                              width: 18.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id': OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistname = result.data?['parkingdetailbyid'] ?? [];


                                return Text("${datalistname['parkingname']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("Address",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 7.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id':OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistaddress = result.data?['parkingdetailbyid'] ?? [];


                                return Text("${datalistaddress['address']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("Vehicle",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 14.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id': OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistvehicle = result.data?['parkingdetailbyid'] ?? [];
                                qrname = datalistvehicle['vehiclenum'].toString();


                                return Text("${datalistvehicle['vehiclename']}(${datalistvehicle['vehiclenum']})",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("Parkingspot",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 25.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id': OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistspot = result.data?['parkingdetailbyid'] ?? [];


                                return Text("${datalistspot['floornum']}(${datalistspot['spotnum']})",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("date",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 38.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id': OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistselecteddate = result.data?['parkingdetailbyid'] ?? [];


                                return Text("${datalistselecteddate['selecteddate']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("Duration",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 35.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id':OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistduration = result.data?['parkingdetailbyid'] ?? [];


                                return Text("${datalistduration['duration']} hours",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("Hours",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 23.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id': OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalisthours = result.data?['parkingdetailbyid'] ?? [];


                                return Text("${datalisthours['starthour']}-${datalisthours['endhour']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Row(
                          children: [

                            Text("Total",
                                style: GoogleFonts.poppins(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                )),
                            SizedBox(
                              width: 49.w,
                            ),
                            Query(
                              options: QueryOptions(
                                document: gql(parkingDeatil),
                                // variables: {'id': NewAcountone.idvaluee},
                                variables: {'id': OngoingPage.saveidd.toString()},

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

                                Map<String, dynamic> datalistcost = result.data?['parkingdetailbyid'] ?? [];


                                return Text("₹${datalistcost['totalcost']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ));
                              },

                            ),

                          ],
                        ),
                      ),

                    ],
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
