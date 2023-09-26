import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sem5demo3/animations/loading%20animation.dart';
import 'package:sem5demo3/parkobject.dart';
import 'package:sem5demo3/parkone.dart';
import 'package:sem5demo3/searchpage.dart';

List<Map<String, dynamic>> data  = [
  {
    'id': '1',
    'position': const LatLng(19.1031122, 72.8370857),
    'assetPath': 'assets/logos/parklogo.png',

  },

  {
    'id': '2',
    'position': const LatLng(19.1118888, 72.8411111),
    'assetPath': 'assets/logos/parklogo.png',

  },

  {
    'id': '3',
    'position': const LatLng(19.092000, 72.8410111),
    'assetPath': 'assets/logos/parklogo.png',

  },
];

class MainHomePage extends StatefulWidget {
  static int id1 = 0;
  static int id2 = 0;
  static int id3 = 0;
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  final Map<String, Marker> _markers = {};

  
  LocationData? currentLocation;
  dynamic parkingonelong =0;
  void getCurrentLocation(){
    Location location = Location();
    location.getLocation().then((location){
      setState(() {
        currentLocation = location;
      });
    });
  }


  @override
  void initState(){
    getCurrentLocation();
    _generateMarkers();
  }

  @override
  Widget build(BuildContext context) {
    var markers =   {
      const Marker(markerId: MarkerId('1'),position: LatLng(19.1031122, 72.8350857)),
      const Marker(markerId: MarkerId('2'),position: LatLng(19.1118888, 72.8411111)),
      const Marker(markerId: MarkerId('3'),position: LatLng(19.092000, 72.8410111)),


    };
    return currentLocation == null ? LoadingPageOne() : Scaffold(
      body:  Stack(
        children:[
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: GoogleMap(
              buildingsEnabled: true,
              // compassEnabled: true,
              rotateGesturesEnabled: true,
              // mapType: MapType.normal,
              tiltGesturesEnabled: true,
              initialCameraPosition: const CameraPosition(
                  target: LatLng(
                      19.1031122, 72.8370857),
                  zoom:15,
              tilt: 15),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              markers: _markers.values.toSet(),
              // markers: markers,
            ),
          ),

          Positioned(
            top: 60,
            right: 30,
            child: GestureDetector(
              onTap: (){
                Get.to(() => const SearchPage(),
                    transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.9),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius:25,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.search_rounded,color: Colors.blueAccent.shade700,size: 30,),
                ),
              ),
            ),
          ),

        ]
      ),
    );

  }


  _generateMarkers() async {
    for (int i = 0; i < data.length;i++){
      BitmapDescriptor markerIcon = await BitmapDescriptor.fromAssetImage(
          const ImageConfiguration(

          size: Size(10, 10),
          ),
          data[i]['assetPath']);

      _markers[i.toString()] = Marker(
          markerId: MarkerId(i.toString()),
          position: data[i]['position'],
          icon: markerIcon,
          // consumeTapEvents: true,
          onTap: (){
            goToPark(i.toString());
            setState(() {
            });
            if (i.toString() == '1'){
              setState(() {
                MainHomePage.id1 = i;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade100,
                  duration: Duration(seconds: 3),
                  showCloseIcon: true,
                  closeIconColor: Colors.white,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Spots Available',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'There are available parking spots',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.green.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }  else if (i.toString() == '2'){
              setState(() {
                MainHomePage.id1 = i;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade100,
                  duration: Duration(seconds: 3),
                  showCloseIcon: true,
                  closeIconColor: Colors.white,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Few Slots available',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.orangeAccent,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Only few Parking spots are available',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.orangeAccent.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (i.toString() == '3') {
              setState(() {
                MainHomePage.id1 = i;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.green.shade100,
                  duration: Duration(seconds: 3),
                  showCloseIcon: true,
                  closeIconColor: Colors.white,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'No Spots Available',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'The Parking Lot is Full',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.green.shade400,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

          }


      );
      setState(() {

      });
    }
  }

  void goToPark(String parkId) {
    // You can perform additional logic here based on the park ID if needed
    Get.to(() => ParkingOne(),
        transition: Transition.cupertinoDialog, duration: const Duration(seconds: 1));
  }

}

