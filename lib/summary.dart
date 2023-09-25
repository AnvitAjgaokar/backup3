import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'client.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({Key? key}) : super(key: key);

  @override
  State<SummaryPage> createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage> {
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
    return GraphQLProvider(
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
                padding: EdgeInsets.only(left: 30, right: 20),
                child: Row(
                  children: [
                    Text("Name",
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        )),
                    SizedBox(
                      width: 120,
                    ),
                    Text("Vehicle",
                        style: GoogleFonts.poppins(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        )
    );
  }
}
