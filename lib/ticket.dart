import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parking Ticket',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          padding: const EdgeInsets.only(left: 15),
          onPressed: () {},
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
            Text(
                "Scan this on the Scanner machine\n when your are in the parking lot",
                style: GoogleFonts.poppins(color: Colors.black, fontSize: 12)),
            QrImage(
              data: "HEllo World",
              version: QrVersions.auto,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
              size: 210,
            ),
            Divider(
              height: 10,
              color: Colors.grey.shade200,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
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
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Anvit Ajgaokar",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 50,
                  ),
                  Text("Ciaz (MH48AC8996)",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Parking Area",
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      )),
                  SizedBox(
                    width: 75,
                  ),
                  Text("Parking Spot",
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
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("San Francisco",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 55,
                  ),
                  Text("1st Floor(A201)",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Duration",
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      )),
                  SizedBox(
                    width: 100,
                  ),
                  Text("Date",
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
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Anvit Ajgaokar",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 30,
                  ),
                  Text("Ciaz (MH48AC8996)",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Hours",
                      style: GoogleFonts.poppins(
                        color: Colors.grey.shade600,
                        fontSize: 13,
                      )),
                  SizedBox(
                    width: 115,
                  ),
                  Text("Phone",
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
            Padding(
              padding: EdgeInsets.only(left: 30),
              child: Row(
                children: [
                  Text("Anvit Ajgaokar",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                    width: 30,
                  ),
                  Text("Ciaz (MH48AC8996)",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
