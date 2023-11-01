import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/ticket.dart';

class OngoingPage extends StatefulWidget {
  static String saveidd = '';
  const OngoingPage({Key? key}) : super(key: key);

  @override
  State<OngoingPage> createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage> {
  List<dynamic> dataList = [];

  final String getbalance = r'''
    query ($fireid: String!){
       balancebyfireid(fireid: $fireid) {
          id
          balance

      }
    }
  ''';
  dynamic wallid;
  dynamic mainbal;
  dynamic totalcost;

  Map<String, dynamic> balancedatalist = {};

  Future<void> _updateWallet() async {
    print("Updating Wallet!!");
    final String updateUserMutation = '''
      mutation() {
        updateWallet(inputData: {
          balancenameId: "${wallid}"
          balance: "${(int.parse(mainbal)+int.parse(totalcost)).toString()}",   
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




  final String deleteDetailMutation = r'''
    mutation($id: ID!) {
      deleteDetail(id: $id) {
        success
      }
    }
  ''';
  dynamic saveid;

  Future<void> _deleteSaved(String userId) async {
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
      print('Error deleting Saved: ${result.exception.toString()}');
    } else {
      final success = result.data?['deleteDetail']['success'];
      if (success) {
        setState(() {
          // Remove the deleted item from the list
          dataList.removeWhere((item) => item['id'] == userId);
        });
        print('Booking deleted successfully');
      } else {
        print('Failed to delete Saved');
      }
    }
  }


  final String listDeatil = r'''
    query ($fireid: String!){
      parkingdetailbyfireid(fireid: $fireid) {
          id
          fireid
          parkingname
          address
          displayphoto
          totalcost

      }
    }
  ''';


  final String getSavedQuery = r'''
    query($fireid: String!) {
      savedbyfireid(fireid: $fireid) {
        id
        fireid
        spotname
        spotaddress
        displayphoto
      }
    }
  ''';
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
    return Scaffold(
      body: Container(
        child: GraphQLProvider(
          client: client,
          child: Query(
            options: QueryOptions(
              document: gql(listDeatil),
              variables: {'fireid': fireid},
            ),
            builder: (QueryResult result, {fetchMore, refetch}) {
              if (result.hasException) {
                print(result.exception.toString());
                return Center(
                  child: Text('Error fetching Balance: ${result.exception.toString()}'),
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

              dataList = result.data?['parkingdetailbyfireid'] ?? [];

              if (dataList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: SvgPicture.asset(
                          "assets/images/search_list_svg.svg",
                          height: 200,
                          width: 200,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("There are no Booked Parking Lots", style: GoogleFonts.poppins(fontSize: 15),
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  final save = dataList[index];
                  saveid = save['id'];
                  totalcost = save['totalcost'];

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 16,
                            ),
                            title: Text(
                              '${save['parkingname']}',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            subtitle: Text(
                              '${save['address']}',
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                '${save['displayphoto']}',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            onTap: () {},
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

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
                              Container(
                                width: 120,
                                child: ElevatedButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context){
                                          return SizedBox(
                                            height: 250,
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

                                                  Text("Want to Cancel your Booking?",style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold),),
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
                                                            Navigator.pop(context);
                                                          },
                                                          child: Text(
                                                            'back',
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
                                                            // Get.to(() => VehicleSelectionPage(),
                                                            //     transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
                                                            _deleteSaved(saveid.toString());
                                                            _updateWallet();
                                                            Navigator.pop(context);

                                                          },
                                                          child: Text(
                                                            'Yes, Cancel',
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
                                          );
                                        });
                                    wallid = balancedatalist['id'];
                                    mainbal = balancedatalist['balance'];
                                    // Handle the first button click
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent, // Transparent background color
                                    onPrimary: Colors.blue,
                                    elevation: 0,
                                    side: BorderSide(
                                      color: Colors.blueAccent.shade700
                                    ),// Text color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0), // Rounded border
                                    ),
                                  ),
                                  child: Text("Cancel",style: GoogleFonts.poppins(
                                      color: Colors.blueAccent.shade700,
                                      fontSize: 13
                                  ),),
                                ),
                              ),
                              Container(
                                width: 120,
                                child: ElevatedButton(

                                  onPressed: () {
                                    setState(() {
                                      OngoingPage.saveidd = saveid;
                                    });
                                    // Handle the second button click
                                    Get.to(() => const ParkingTicket(),
                                        transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
                                  },

                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent, // Transparent background color
                                    onPrimary: Colors.blue, // Text col
                                    elevation: 0,// or
                                    side: BorderSide(
                                      color: Colors.blueAccent.shade700
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0), // Rounded border
                                    ),
                                  ),
                                  child: Text("View Ticket",style: GoogleFonts.poppins(
                                    color: Colors.blueAccent.shade700,
                                    fontSize: 13
                                  ),),
                                ),
                              ),





                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
