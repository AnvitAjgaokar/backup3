import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/bars/barhome.dart';

import 'bargraapg.dart';

class MainSummaryPage extends StatefulWidget {
  const MainSummaryPage({Key? key}) : super(key: key);

  @override
  State<MainSummaryPage> createState() => _MainSummaryPageState();
}

class _MainSummaryPageState extends State<MainSummaryPage> {
  List<double> weeklySummary = [
    2,
    8,
    1,
    5,
    4,
    7,
    3,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Summary Report',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 20,
          ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align children to the left
        children: [
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text(
                  "Total Amount:",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                SizedBox(width: 10),
                Text("₹450", style: GoogleFonts.poppins(fontSize: 14)),
              ],
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: EdgeInsets.only(left: 20),

            child: Text(
              "Weekly Hours:",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: MyBargraph(
              weeklySummary: weeklySummary,
            ),
          ),
        ],
      ),
    );
  }
}
