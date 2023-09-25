import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/main/ewallet.dart';
import 'package:sem5demo3/main/mainpage.dart';
import 'package:sem5demo3/parkobject.dart';
import 'package:sem5demo3/selectvehicle.dart';
import 'package:sizer/sizer.dart';

import 'client.dart';

class SummaryPage extends StatefulWidget {
  static bool emptywall = true;
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
  // FirebaseAuth auth = FirebaseAuth.instance;

  dynamic totalcost;
  dynamic wallid;
  dynamic mainbal;
  dynamic maindetid;

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

  bool _toggle = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  final String getbalance = r'''
    query ($fireid: String!){
       balancebyfireid(fireid: $fireid) {
          id
          balance

      }
    }
  ''';

  Map<String, dynamic> balancedatalist = {};

  Future<void> _updateWallet() async {
    print("Updating Wallet!!");
    final String updateUserMutation = '''
      mutation() {
        updateWallet(inputData: {
          balancenameId: "${wallid}"
          balance: "${(int.parse(mainbal)-int.parse(totalcost)).toString()}",   
        }) {
          balancename {
            id
            balance
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
        variables: {'id': wallid}
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error updating Wallet: ${result.exception.toString()}');
    } else {
      print('Wallet updated successfully');
    }
  }


  Future<void> _deleteDetail(String userId) async {
    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final MutationOptions options = MutationOptions(
      document: gql(deleteDetailMutation),
      variables: {'id': userId},
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error deleting Detail: ${result.exception.toString()}');
    } else {
      final success = result.data?['deleteDetail']['success'];
      if (success) {
        print('Detail deleted successfully');
      } else {
        print('Failed to delete Detail');
      }
    }
  }

  final String deleteDetailMutation = r'''
    mutation($id: ID!) {
      deleteDetail(id: $id) {
        success
      }
    }
  ''';



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
              'Summary Page',
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

          body: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              height: 100.0.h,
              child: Column(
                children:[

                  Padding(
                  padding: EdgeInsets.only(left: 20, right: 20,top: 20,bottom: 120),

                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
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
                                Text("${datalist['parkingname']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                Text("${datalist['address']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                  width: 18.w,
                                ),
                                Text("${datalist['vehiclename']}(${datalist['vehiclenum']})",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                Text("${datalist['floornum']}(${datalist['spotnum']})",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                Text("${datalist['selecteddate']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                Text("${datalist['duration']} hours",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                Text("${datalist['starthour']}-${datalist['endhour']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
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
                                Text("₹${datalist['totalcost']}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),
                ),

                  // SizedBox(height: 0.5.h,),

                  Container(
                    width: double.infinity,
                    height: 45,
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          wallid = balancedatalist['id'];
                          mainbal = balancedatalist['balance'];
                          totalcost = datalist['totalcost'];
                          maindetid = datalist['id'];
                        });

                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context){
                              return SizedBox(
                                height: 200,
                                child: Center(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Divider(
                                        color: Colors.grey.shade400,
                                        thickness: 5,
                                        height:40,
                                        indent: 140,
                                        endIndent: 140,
                                      ),

                                      Text("Confirm Booking?",style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold,),),
                                      Divider(
                                        color: Colors.grey.shade300,
                                        thickness: 2,
                                        height:10,
                                        indent: 15,
                                        endIndent: 15,
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),

                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 180,
                                            height: 45,
                                            padding: const EdgeInsets.only(left: 20, right: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                _deleteDetail(maindetid.toString());
                                                Get.offAll(ParkingOne());
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: const StadiumBorder(),
                                                  backgroundColor:
                                                  Colors.blueAccent.shade200.withOpacity(0.2),
                                                  elevation: 0),
                                              child: Text(
                                                'Cancel',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15, color: Colors.blueAccent.shade700),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 180,
                                            height: 45,
                                            padding: const EdgeInsets.only(left: 20, right: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                setState(() {
                                                  _toggle = !_toggle;
                                                });

                                                if (int.parse(mainbal) == 0 ){
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
                                                            'No Balance',

                                                            style: GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                          const SizedBox(height: 8),
                                                          Text(
                                                            'Please Recharge Your wallet',
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              color: Colors.red.shade400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                  Get.to(Ewallet());
                                                } else {
                                                  _updateWallet();
                                                  Navigator.pop(context);

                                                  ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      backgroundColor: Colors.green.shade100,
                                                      duration: Duration(seconds: 6),
                                                      showCloseIcon: true,
                                                      closeIconColor: Colors.white,
                                                      content: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        mainAxisSize: MainAxisSize.max,
                                                        children: [
                                                          Text(
                                                            'Booking Successful',
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.green,
                                                            ),
                                                          ),
                                                          SizedBox(height: 8),
                                                          Text(
                                                            'Your parking slot has been booked',
                                                            style: GoogleFonts.poppins(
                                                              fontSize: 16,
                                                              color: Colors.green.shade400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );


                                                  Future.delayed(Duration(seconds: 2), () {
                                                    Get.offAll(MainPage());
                                                  });

                                                }


                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(),
                                                backgroundColor: Colors.blueAccent.shade700,
                                              ),
                                              child: Text(
                                                'Yes',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 13, color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });

                      },
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.blueAccent.shade700,
                        elevation: 9,
                      ),
                      child: Text(
                        'Confirm Booking',
                        style: GoogleFonts.poppins(fontSize: 16),
                      ),
                    ),
                  ),

                  Query(
                    options: QueryOptions(
                      document: gql(parkingDeatil),
                      // variables: {'id': NewAcountone.idvaluee},
                      variables: {'id': SelectVehicle.maindetailiddd},

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

                      datalist = result.data?['parkingdetailbyid'] ?? [];


                      return Visibility(visible: false,child: Text("",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),));
                    },

                  ),

                  Query(
                    options: QueryOptions(
                      document: gql(getbalance),
                      // variables: {'id': NewAcountone.idvaluee},
                      variables: {'fireid': fireid},

                    ),
                    builder: (QueryResult result, {fetchMore, refetch}) {
                      if (result.hasException) {
                        print(result.exception.toString());
                        return Center(
                          child: Text(
                              'Error fetching balance: ${result.exception.toString()}'),
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

                      balancedatalist = result.data?['balancebyfireid'] ?? [];


                      return Visibility(visible: false,child: Text("",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),));
                    },

                  ),
                ]
              ),






            ),
          ),
        )
    );
  }
}
