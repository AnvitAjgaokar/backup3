import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/selectvehicle.dart';

class ParkingLotPage extends StatefulWidget {
  // final String title;
  final String subtitle;
  final List<String> imageUrls;
  final String lotName;
  final String time;
  final String distance;
  final String valetAvailability;
  // final String desctitle;
  final String description;
  final String price;

  ParkingLotPage({
    // required this.title,
    required this.subtitle,
    required this.imageUrls,
    required this.lotName,
    required this.time,
    required this.distance,
    required this.valetAvailability,
    // required this.desctitle,
    required this.description,
    required this.price,
  });

  @override
  _ParkingLotPageState createState() => _ParkingLotPageState();
}

class _ParkingLotPageState extends State<ParkingLotPage> {
  int _currentPageIndex = 0;
  bool _isSaved = false;

  // PageController _pageController = PageController();
  // late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parking Details',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          onPressed: () {
            // Navigator.pop(context); // Go back when the back button is pressed
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
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
            SizedBox(
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
                    itemCount: widget.imageUrls.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SvgPicture.asset(
                            widget.imageUrls[index],
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
                Positioned(
                  bottom: 10.0,
                  left: 0.0,
                  right: 0.0,
                  child: DotsIndicator(
                    dotsCount: widget.imageUrls.length,
                    position: _currentPageIndex.toDouble(),
                    decorator: DotsDecorator(
                      activeColor: Colors.blueAccent.shade700,
                      color: Colors.white,
                      activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(5.0),
                          // Adjust the left radius to elongate the active dot
                          right: Radius.circular(
                              5.0), // Adjust the right radius to elongate the active dot
                        ),
                      ),
                      activeSize: Size(30.0,
                          8.0), // Adjust the size to elongate the active dot
                    ),
                  ),
                ),
              ],
            ),

            // Rest of the content...
            // Name of the parking lot and save button
            ListTile(
              title: Text(
                widget.lotName,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black),
              ),
              subtitle: Text(
                widget.subtitle,
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black45),
              ),
              trailing: IconButton(
                onPressed: () {
                  setState(() {
                    _isSaved = !_isSaved; // Toggle the saved state
                  });
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
                InfoBox(icon: Icons.location_pin, value: widget.time),
                InfoBox(
                    icon: Icons.watch_later_rounded, value: widget.distance),
                InfoBox(
                    icon: Icons.person_rounded,
                    value: widget.valetAvailability),
              ],
            ),

            Divider(
              height: 5,
              color: Colors.white38,
              thickness: 5,
            ),

            // Description of the parking lot
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    style: GoogleFonts.poppins(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Add some spacing between the title and description
                  Container(
                    height: 110,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.description,
                        style: GoogleFonts.poppins(
                            fontSize: 15.0, color: Colors.black45),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Rectangle to display price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  height: 87,
                  padding:
                  EdgeInsets.only(top: 12, bottom: 16, left: 10, right: 16),
                  // Add horizontal padding
                  color: Colors.blueAccent.shade100.withOpacity(0.2),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '₹${widget.price}',
                        style: GoogleFonts.poppins(
                            color: Colors.blueAccent.shade700,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
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

            SizedBox(
              height: 15,
            ),
            Divider(
              height: 10,
              color: Colors.grey.shade200,
              thickness: 2,
            ),

            SizedBox(
              height: 15,
            ),

            // Book and Cancel buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 180,
                  height: 45,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.blueAccent.shade700),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor:
                        Colors.blueAccent.shade200.withOpacity(0.2),
                        elevation: 0),
                  ),
                ),
                Container(
                  width: 180,
                  height: 45,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Get.to(() => SelectVehicle(),
                          transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));

                    },
                    child: Text(
                      'Book Parking',
                      style: GoogleFonts.poppins(
                          fontSize: 13, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
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
  }

  // @override
  // void initState() {
  //   super.initState();
  //   // _startAutoScroll();
  // }
  //
  // // void _startAutoScroll() {
  // //   _timer = Timer.periodic(Duration(seconds:2), (timer) {
  // //     if (_currentPageIndex < widget.imageUrls.length - 1) {
  // //       _pageController.animateToPage(_currentPageIndex + 1,
  // //           duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  // //     } else {
  // //       _pageController.animateToPage(0,
  // //           duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  // //     }
  // //   });
  // // }
  //
  // @override
  // void dispose() {
  //   // _timer.cancel();
  //   // _pageController.dispose();
  //   super.dispose();
  // }
}

class InfoBox extends StatelessWidget {
  final IconData icon;
  final String value;

  const InfoBox({required this.icon, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
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
          SizedBox(width: 5),
          Text(
            value,
            style: GoogleFonts.poppins(color: Colors.blueAccent.shade700),
          ),
        ],
      ),
    );
  }
}
