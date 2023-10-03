import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/parkingpage/cancelled.dart';
import 'package:sem5demo3/parkingpage/done.dart';
import 'package:sem5demo3/parkingpage/ongoing.dart';
import 'package:sizer/sizer.dart';

class MainParkingPage extends StatefulWidget {
  const MainParkingPage({Key? key}) : super(key: key);

  @override
  State<MainParkingPage> createState() => _MainParkingPageState();
}

class _MainParkingPageState extends State<MainParkingPage>
    with SingleTickerProviderStateMixin {
  // Store the index of the selected tab

  late TabController controller;

  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    controller.addListener(() {
      setState(() {});
    });
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          title: Text(
            'My Parking',
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
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
          backgroundColor: Colors.white,
          // bottomOpacity: 0,
          elevation: 0,
          bottom: TabBar(controller: controller, tabs: [
            // ongoing tab
            // Tab(
            //   child: Container(
            //     // padding: const EdgeInsets.only(left: 20, right: 20),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // Get.to(() => const SelectVehicle(),
            //         //     transition: Transition.cupertinoDialog,
            //         //     duration: const Duration(seconds: 1));
            //         // setState(() {
            //         //   mainfireid = fireid;
            //         //   mainnow= formattedDate.toString();
            //         //   ParkingOne.nameee = _name;
            //         // });
            //         // _createDetails();
            //       },
            //       style: ElevatedButton.styleFrom(
            //         side: BorderSide(color: Colors.blueAccent.shade700),
            //         shape: const StadiumBorder(),
            //         backgroundColor: controller.index == 0
            //             ? Colors.blueAccent.shade700
            //             : Colors.white,
            //       ),
            //       child: Text(
            //         'Ongoing',
            //         style: GoogleFonts.poppins(
            //           fontSize: 11,
            //           color: controller.index == 0
            //               ? Colors.white
            //               : Colors.blueAccent.shade700, // Change text color
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            //
            // // compeleted tab
            // Tab(
            //   child: Container(
            //     width: 25.w,
            //     // padding: const EdgeInsets.only(left: 20, right: 20),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // Get.to(() => const SelectVehicle(),
            //         //     transition: Transition.cupertinoDialog,
            //         //     duration: const Duration(seconds: 1));
            //         // setState(() {
            //         //   mainfireid = fireid;
            //         //   mainnow= formattedDate.toString();
            //         //   ParkingOne.nameee = _name;
            //         // });
            //         // _createDetails();
            //       },
            //       style: ElevatedButton.styleFrom(
            //         side: BorderSide(color: Colors.blueAccent.shade700),
            //         shape: const StadiumBorder(),
            //         backgroundColor: controller.index == 1
            //             ? Colors.blueAccent.shade700
            //             : Colors.white,
            //       ),
            //       child: Text(
            //         'done',
            //         style: GoogleFonts.poppins(
            //           fontSize: 11,
            //           color: controller.index == 1
            //               ? Colors.white
            //               : Colors.blueAccent.shade700, // Change text color
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            //
            // // cancelled tab
            // Tab(
            //   child: Container(
            //     // padding: const EdgeInsets.only(left: 20, right: 20),
            //     child: ElevatedButton(
            //       onPressed: () {
            //         // Get.to(() => const SelectVehicle(),
            //         //     transition: Transition.cupertinoDialog,
            //         //     duration: const Duration(seconds: 1));
            //         // setState(() {
            //         //   mainfireid = fireid;
            //         //   mainnow= formattedDate.toString();
            //         //   ParkingOne.nameee = _name;
            //         // });
            //         // _createDetails();
            //       },
            //       style: ElevatedButton.styleFrom(
            //         side: BorderSide(color: Colors.blueAccent.shade700),
            //         shape: const StadiumBorder(),
            //         backgroundColor: controller.index == 2
            //             ? Colors.blueAccent.shade700
            //             : Colors.white,
            //       ),
            //       child: Text(
            //         'canceled',
            //         style: GoogleFonts.poppins(
            //           fontSize: 11,
            //           color: controller.index == 2
            //               ? Colors.white
            //               : Colors.blueAccent.shade700, // Change text color
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Tab(
              child: Container(
                decoration: BoxDecoration(
                  color: controller.index == 0
                      ? Colors.blueAccent.shade700
                      : Colors.white,
                  border: Border.all(color: Colors.blueAccent.shade700),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    'Ongoing',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: controller.index == 0
                          ? Colors.white
                          : Colors.blueAccent.shade700,
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                  color: controller.index == 1
                      ? Colors.blueAccent.shade700
                      : Colors.white,
                  border: Border.all(color: Colors.blueAccent.shade700),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    'Done',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: controller.index == 1
                          ? Colors.white
                          : Colors.blueAccent.shade700,
                    ),
                  ),
                ),
              ),
            ),
            Tab(
              child: Container(
                decoration: BoxDecoration(
                  color: controller.index == 2
                      ? Colors.blueAccent.shade700
                      : Colors.white,
                  border: Border.all(color: Colors.blueAccent.shade700),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(
                    'Canceled',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: controller.index == 2
                          ? Colors.white
                          : Colors.blueAccent.shade700,
                    ),
                  ),
                ),
              ),
            ),

          ]),

          // completed tab
        ),
        body: TabBarView(controller: controller, children: [
          OngoingPage(),
          DonePage(),
          Cancelled()

        ]));
  }
}
