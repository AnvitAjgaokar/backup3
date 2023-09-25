// import 'package:flutter/cupertino.dart';
// import 'package:graphql_flutter/graphql_flutter.dart';
// import 'package:sem5demo3/client.dart';
// import 'package:sem5demo3/parkclass.dart';
//
// // ParkingLotPage parkingLot = ParkingLotPage(
// //   title: 'Parking Details',
// //   subtitle: '989,Inorbit mall, Mumbai',
// //   imageUrls: [
// //     'assets/images/parkone4svg.svg',
// //     'assets/images/parkone4svg.svg',
// //     'assets/images/parkone4svg.svg',
// //     'assets/images/parkone4svg.svg',
// //
// //   ],
// //   lotName: 'Parking Lot Name',
// //   time: '2 Km',
// //   distance: '8AM - 10PM',
// //   valetAvailability: 'No Valet',
// //   desctitle: 'Description',
// //   description:
// //   'A parking lot is a designated area or facility designed for vehicles to park temporarily while not in use. It provides a convenient and safe space for drivers to park their cars, motorcycles, or other vehicles. Parking lots are commonly found in various locations, such as shopping malls, office buildings, airports, and public spaces, to accommodate the parking needs of visitors, customers, and employees. They are often managed by parking attendants or automated systems to ensure organized and efficient parking.',
// //   price: '40',
// // );
//
// class ParkingMainPage extends StatefulWidget {
//   const ParkingMainPage({Key? key}) : super(key: key);
//
//   @override
//   State<ParkingMainPage> createState() => _ParkingMainPageState();
// }
//
// class _ParkingMainPageState extends State<ParkingMainPage> {
//
//   final String parkingSpotDeatil = r'''
//     query (){
//       parkingspotbyid(id: $id) {
//         name
//         address
//         distance
//         startTime
//         endTime
//         valet
//         description
//         rate
//       }
//     }
//   ''';
//
//   Map<String, dynamic> datalist = {};
//
//   @override
//   Widget build(BuildContext context) {
//     final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
//       GraphQLClient(
//         cache: GraphQLCache(),
//         link: httpLink,
//       ),
//     );
//     return GraphQLProvider(
//       client: client,
//       child: ParkingLotPage(
//
//           subtitle: subtitle,
//           imageUrls: [
//             'assets/images/parkone4svg.svg',
//             'assets/images/parkone4svg.svg',
//             'assets/images/parkone4svg.svg',
//             'assets/images/parkone4svg.svg',
//
//           ],
//           lotName: lotName,
//           time: time,
//           distance: distance,
//           valetAvailability: valetAvailability,
//           description: description,
//           price: price),
//     );
//   }
// }
