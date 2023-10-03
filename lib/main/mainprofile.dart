import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/addvehicle.dart';
import 'package:sem5demo3/animations/loading%20animation.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/main/ewallet.dart';
import 'package:sem5demo3/sign%20_in_up/newacc.dart';
import 'package:sem5demo3/sign%20_in_up/signin.dart';
import 'package:sem5demo3/updateprofile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  FirebaseAuth auth = FirebaseAuth.instance;

  final String userDeatil = r'''
    query ($fireid: String!){
      usersbyfireid(fireid: $fireid) {
        username
        email
      }
    }
  ''';

  Map<String, dynamic> datalist = {};

  // FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String fireid = auth.currentUser!.uid.toString();
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return  GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile',
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
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Center(
                child: Column(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/logos/chamu.jpeg"),
                      radius: 70,


                    ),
                    const SizedBox(height: 14,),
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
                        dynamic _username  = datalist['username'];


                        return Text("${_username}",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),);
                      },

                    ),
                    const SizedBox(height: 5,),
                    // Text("Anvit Ajgaokar",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),),
                    Query(
                      options: QueryOptions(
                        document: gql(userDeatil),
                        // variables: {'id' :NewAcountone.idvaluee },
                        variables: {'fireid': fireid},

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

                        datalist = result.data?['usersbyfireid'] ?? [];
                        dynamic _email  = datalist['email'];


                        return Text("${_email}",style: GoogleFonts.poppins(fontWeight: FontWeight.w300,fontSize: 16 ,color: Colors.black),);
                      },

                    ),


                    // const SizedBox(height: 5,),
                    // Text("anvitajgaokar14@gmail.com",style: GoogleFonts.poppins(fontWeight: FontWeight.w300,fontSize: 16 ,color: Colors.black),),

                  ],
                ),
              ),
            ),

            Divider(
              color: Colors.grey.shade300,
              thickness: 2,
              height:40,
            ),

            ListTile(
              title: Text("Edit Profile",style: GoogleFonts.poppins(fontSize: 18),),
              leading: const Icon(Icons.person_outline_rounded,size: 35,),
              onTap: () {
                // Handle List Tile 3 tap
                Get.to(() => const UpdateProfile(),
                    transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));


              },
            ),
            const SizedBox(height: 10,),

            ListTile(
              title: Text("E-Wallet",style: GoogleFonts.poppins(fontSize: 18),),
              leading: const Icon(Icons.account_balance_wallet_outlined,size: 35,),
              onTap: () {
                // Handle List Tile 3 tap
                // print('id ${NewAcountone.idvaluee}');
                Get.to(() => const Ewallet(),
                    transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));

              },
            ),
            const SizedBox(height: 10,),

            ListTile(
              title: Text("Summary",style: GoogleFonts.poppins(fontSize: 18),),
              leading: const Icon(Icons.bar_chart_rounded,size: 35,),
              onTap: () {
                FirebaseAuth.instance.signOut();
                // Handle List Tile 3 tap
              },
            ),
            const SizedBox(height: 10,),

            ListTile(
              title: Text("Add Car",style: GoogleFonts.poppins(fontSize: 18),),
              leading: const Icon(Icons.directions_car,size: 35,),
              onTap: () {
                // Handle List Tile 3 tap
                Get.to(() => AddVehiclePage(),
                    transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));

              },
            ),
            const SizedBox(height: 10,),


            ListTile(
              title: Text("Logout",style: GoogleFonts.poppins(fontSize: 18,color: Colors.red),),
              leading: const Icon(Icons.logout_rounded,size: 35,color: Colors.red,),
              onTap: () {
                // Handle List Tile 3 tap

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

                              Text("Are You Sure?",style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold,),),
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
                                        // Get.to(() => VehicleSelectionPage(),
                                        //     transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
                                        FirebaseAuth.instance.signOut();  
                                        Get.offAll(() => const LoginPage(),
                                            transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));

                                      },
                                      child: Text(
                                        'Yes, Logout',
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

              },
            ),


          ],
        ),

      ),
    );
  }


}
