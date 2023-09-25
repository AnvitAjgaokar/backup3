import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/parkobject.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _originalParkingSpotList = [];
  List<dynamic> _parkingspot = [];

  bool _isResultvisible = false;

  final String getParkingspotQuery = r'''
    query {
      parkingspot {
        id
        name
        address
        distance
        rate
      }
    }
  ''';

  Widget  _buildParkingSpotList() {
    if (_parkingspot.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/images/search_list_svg.svg",height: 200,width:200,),
            SizedBox(height: 10,),
            Text("Serach For Parking Lots",style: GoogleFonts.poppins(fontSize: 15),)

          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _parkingspot.length,
      itemBuilder: (context, index) {
        final spot = _parkingspot[index];
        final spotid = spot['id'];
        return GestureDetector(
          onTap: (){
            // Get.to(() => ParkLotObject(),arguments: spotid,
            //     transition: Transition.cupertinoDialog, duration: Duration(seconds: 1));
          },
          child: Card( // Wrap the ListTile with a Card
            elevation: 2, // Add elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Rounded corners
            ),
            child: ListTile(
              leading: Padding(
                padding: EdgeInsets.only(top: 8),
                child: Image.asset(
                  "assets/logos/parklogo.png",
                  width: 25,
                  height: 25,
                ),
              ),
              title: Text(spot['name'],
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 17 ,
                      fontWeight: FontWeight.bold)),
              subtitle: Text('${spot['address']}',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 13,
                  )),
              trailing: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${spot['distance']}\n',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '${spot['rate']}₹',
                      style: GoogleFonts.poppins(
                        color: Colors.blueAccent.shade700, // Change the color to blue
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextSpan(
                      text: '/hour',
                      style: GoogleFonts.poppins(
                        color: Colors.grey, // Change the color to blue
                        fontSize: 13,

                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _filterParkingSpots(String query) {
    if (query.isEmpty) {
      setState(() {
        _parkingspot = _originalParkingSpotList; // Reset the list if query is empty
      });
      return;
    }

    final List<dynamic> filteredList = [];
    for (var spot in _originalParkingSpotList) {
      if (spot['name'].toLowerCase().contains(query.toLowerCase())) {
        filteredList.add(spot);
      }
    }

    setState(() {
      _parkingspot = filteredList;
    });
  }



  @override
  Widget build(BuildContext context) {

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
        client: client,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Search Page',
              style: GoogleFonts.poppins(
                  color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              padding: const EdgeInsets.only(left: 15),
              onPressed: () {
                Get.back(); // Go back when the back button is pressed
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            elevation: 0,
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: EdgeInsets.all(16),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      _filterParkingSpots(value);
                      _isResultvisible = true;

                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search for a parking spot...',
                    prefixIcon: Icon(Icons.search,color: Colors.grey.shade700,),
                    suffixIcon:  GestureDetector(
                      onTap: () {
                        _searchController.clear();
                        _filterParkingSpots('');
                        _isResultvisible = false;
                      },
                      child: _searchController.text.isNotEmpty
                          ? Icon(Icons.clear, color: Colors.grey.shade700)
                          : SizedBox.shrink(),
                    ),
                    filled: true,
                    fillColor: Colors.grey[300], // Background color
                    contentPadding: EdgeInsets.all(12), // Padding
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded borders
                      borderSide: BorderSide.none, // No border
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20,),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Visibility(
                    visible: _isResultvisible,
                    child: Text("Results (${_parkingspot.length})",
                        style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold))),
              ),
              SizedBox(height: 20,),

              Container(
                child: Expanded(
                  child: Query(
                    options: QueryOptions(
                      document: gql(getParkingspotQuery),
                    ),
                    builder:(QueryResult result, {fetchMore, refetch}) {
                      if (result.hasException) {
                        print(result.exception.toString());
                        return Center(
                          child: Text(
                              'Error fetching Parkingspots: ${result.exception.toString()}'),
                        );
                      }

                      if (result.isLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      _originalParkingSpotList = result.data?['parkingspot'] ?? [];
                      // _parkingspot = _originalParkingSpotList;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        child: _buildParkingSpotList(), // Use the method to build the list
                      );

                    },
                  ),
                ),
              ),


            ],
          ),

        ));
  }
}
