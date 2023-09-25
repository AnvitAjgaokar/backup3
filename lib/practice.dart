import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/bookingdetail.dart';
import 'package:sem5demo3/parkobject.dart';
import 'package:sem5demo3/parkone.dart';
import 'addvehicle.dart';

class Vehicle {
  final String name;
  final String numberPlate;

  Vehicle({required this.name, required this.numberPlate});
}

class VehicleController extends GetxController {
  RxList<Vehicle> vehicles = <Vehicle>[].obs;

  void addVehicle(Vehicle vehicle) {
    vehicles.add(vehicle);
  }
}

class VehicleSelectionPage extends StatelessWidget {
  final vehicleController = Get.put(VehicleController());

  int _selectedVehicleIndex =
  -1; // Default value to indicate no vehicle is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Your Vehicle',
          style: GoogleFonts.poppins(color: Colors.black, fontSize: 20),
        ),
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          onPressed: () {
            // Go back when the back button is pressed
            Get.to(() => ParkingOne(),
                transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        bottomOpacity: 0,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return Container(
                height: vehicleController.vehicles.isEmpty ? 0 : 420,
                child: ListView.builder(
                  itemCount: vehicleController.vehicles.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                      EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      child: Material(
                        color: Colors.white,
                        elevation: 4,
                        // Set the elevation (shadow)
                        borderRadius: BorderRadius.circular(10),
                        borderOnForeground: true,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            _selectedVehicleIndex = index;
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: _selectedVehicleIndex == index
                                    ? Colors.blueAccent.shade700
                                    : Colors.transparent,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/selectcar.jpg',
                                  // Replace with the path to your image
                                  height: 60,
                                  width: 60,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      vehicleController.vehicles[index].name,
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      vehicleController
                                          .vehicles[index].numberPlate,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13, color: Colors.black45),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Radio<int>(
                                  activeColor: Colors.blueAccent.shade700,
                                  value: index,
                                  groupValue: _selectedVehicleIndex,
                                  onChanged: (int? value) {
                                    _selectedVehicleIndex = value ?? -1;
                                    vehicleController.vehicles.refresh();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => AddVehiclePage(),
                      transition: Transition.rightToLeft,
                      duration: Duration(milliseconds: 500))
                      ?.then((newVehicle) {
                    if (newVehicle != null) {
                      // Add the new vehicle to the list
                      vehicleController.addVehicle(newVehicle);
                    }
                  });
                },
                child: Text(
                  'Add New Vehicle',
                  style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.blueAccent.shade700,
                      fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Colors.blueAccent.shade200.withOpacity(0.2),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Divider(
              height: 10,
              color: Colors.grey.shade200,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () {
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
          ],
        ),
      ),
    );
  }
}
