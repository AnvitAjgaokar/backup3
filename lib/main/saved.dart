import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sem5demo3/animations/loading%20animation.dart';

import '../client.dart';

class MainSavePage extends StatefulWidget {
  const MainSavePage({Key? key}) : super(key: key);
  @override
  State<MainSavePage> createState() => _MainSavePageState();
}

class _MainSavePageState extends State<MainSavePage> {
  // Sample list of data for demonstration
  // List<Map<String, dynamic>> dataList = [
  //   {
  //     'title': 'WellBack North',
  //     'subtitle': 'Subtitle 1',
  //     'prefixPhoto': 'assets/logos/chamu.jpeg',
  //     // 'suffixIcon': Icons.arrow_forward,
  //   },
  //   {
  //     'title': 'Item 2',
  //     'subtitle': 'Subtitle 2',
  //     'prefixPhoto': 'assets/logos/chamu.jpeg',
  //     // 'suffixIcon': Icons.arrow_forward,
  //   },
  //   {
  //     'title': 'Item 3',
  //     'subtitle': 'Subtitle 3',
  //     'prefixPhoto': 'assets/logos/chamu.jpeg',
  //     // 'suffixIcon': Icons.arrow_forward,
  //   },
  //   // Add more items as needed
  // ];

  // dynamic  dataList =[];

  // Filtered data list based on search
  // List<Map<String, dynamic>> filteredDataList = [];

  // TextEditingController searchController = TextEditingController();
  // FocusNode searchFocus = FocusNode(); // Create a FocusNode
  List<dynamic> dataList = [];
  Future<void> _deleteSaved(String userId) async {
    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final MutationOptions options = MutationOptions(
      document: gql(deleteSavedMutation),
      variables: {'id': userId},
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error deleting Saved: ${result.exception.toString()}');
    } else {
      final success = result.data?['deleteSaved']['success'];
      if (success) {
        setState(() {
          // Remove the deleted item from the list
          dataList.removeWhere((item) => item['id'] == userId);
        });
        print('Saved deleted successfully');
      } else {
        print('Failed to delete Saved');
      }
    }
  }

  final String deleteSavedMutation = r'''
    mutation($id: ID!) {
      deleteSaved(id: $id) {
        success
      }
    }
  ''';

  bool _toggle = false;

  @override
  void initState() {
    super.initState();
    // Initialize filteredDataList with the original dataList
    // filteredDataList.addAll(dataList);
  }

  @override
  void dispose() {
    // Dispose of the FocusNode when it's no longer needed
    // searchFocus.dispose();
    super.dispose();
  }

  final String getSavedQuery = r'''
    query($fireid: String!) {
      savedbyfireid(fireid: $fireid) {
        id
        fireid
        spotname
        spotaddress

      }
    }
  ''';
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
      client: client,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Saved',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            leading: IconButton(
              padding: const EdgeInsets.only(left: 15),
              onPressed: () {
                // Handle the back button action
              },
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
            ),
            backgroundColor: Colors.transparent,
            bottomOpacity: 0,
            elevation: 0,
          ),
          body: Query(options: QueryOptions(
            document: gql(getSavedQuery),
            // variables: {'id': NewAcountone.idvaluee},
            variables: {'fireid':fireid},

          ),
            builder: (QueryResult result, {fetchMore, refetch}) {
              if (result.hasException) {
                print(result.exception.toString());
                return Center(
                  child: Text(
                      'Error fetching Balance: ${result.exception.toString()}'),
                );
              }

              if (result.isLoading) {
                return const LoadingPageOne();
              }

              dataList = result.data?['savedbyfireid'] ?? [];

              if (dataList.isEmpty){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              _toggle = !_toggle;
                            });
                          },
                          child: SvgPicture.asset(
                            "assets/images/search_list_svg.svg",
                            height: 200,
                            width: 200,
                          )),
                      const SizedBox(height: 10,),
                      Text("There are no Saved Parking Lots",style: GoogleFonts.poppins(fontSize: 15),)

                    ],
                  ),
                );
              }
              return Column(
                children: [

                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _toggle = !_toggle;
                      });
                    },
                    child: const SizedBox(
                      height: 20,
                      width: double.infinity,
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(12),
                  //   child: Focus(
                  //     onFocusChange: (hasFocus) {
                  //       // Change border and prefixIcon color based on focus state
                  //       setState(() {});
                  //     },
                  //     child: TextField(
                  //       controller: searchController,
                  //       focusNode: searchFocus, // Assign the FocusNode
                  //       onChanged: (text) {
                  //         // Filter the dataList based on the search text
                  //         setState(() {
                  //           filteredDataList = dataList.where((item) {
                  //             final title = item['title'].toLowerCase();
                  //             final subtitle = item['subtitle'].toLowerCase();
                  //             final searchQuery = text.toLowerCase();
                  //             return title.contains(searchQuery) ||
                  //                 subtitle.contains(searchQuery);
                  //           }).toList();
                  //         });
                  //       },
                  //       decoration: InputDecoration(
                  //         prefixIcon: Icon(
                  //           Icons.search_rounded,
                  //           color: searchFocus.hasFocus
                  //               ? Colors.blueAccent.shade700 // Blue color when in focus
                  //               : Colors.grey, // Grey color when out of focus
                  //         ),
                  //         suffixIcon: GestureDetector(
                  //           onTap: () {
                  //             // Clear the text field and unfocus it
                  //             searchController.clear();
                  //             searchFocus.unfocus();
                  //           },
                  //           child: Icon(
                  //             Icons.clear,
                  //             color: searchFocus.hasFocus
                  //                 ? Colors.blueAccent.shade700 // Blue color when in focus
                  //                 : Colors.grey, // Grey color for clear icon
                  //           ),
                  //         ),
                  //         hintText: "Search",
                  //         border: OutlineInputBorder(
                  //           borderRadius: BorderRadius.circular(10.0),
                  //           borderSide: BorderSide(
                  //             color: searchFocus.hasFocus
                  //                 ? Colors.blueAccent.shade700 // Blue color when in focus
                  //                 : Colors.grey, // Grey color when out of focus
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: dataList.length,
                      // itemCount: filteredDataList.length,
                      itemBuilder: (context, index) {
                        final save = dataList[index];
                        final saveid = save['id'];

                        // final item = filteredDataList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Card(
                            elevation: 5, // Add elevation to the Card
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 16,
                              ),
                              title: Text(
                                '${save['spotname']}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              subtitle: Text(
                                '${save['spotaddress']}',
                                style: GoogleFonts.poppins(fontSize: 13),
                              ),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.asset(
                                  'assets/logos/chamu.jpeg',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              trailing: IconButton(icon: Icon(Icons.bookmark,
                                color: Colors.blueAccent.shade700,), onPressed: () {
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

                                              Text("Remove from Bookmark?",style: GoogleFonts.poppins(fontSize: 22,fontWeight: FontWeight.bold),),
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
                                                        _deleteSaved(saveid.toString());
                                                        Navigator.pop(context);

                                                      },
                                                      child: Text(
                                                        'Yes, Remove',
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
                                    });},),
                              onTap: () {

                              },
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              );
            },
          )
      ),
    );
  }
}