import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sem5demo3/client.dart';
import 'package:sem5demo3/summary.dart';
import 'package:sizer/sizer.dart';

class Ewallet extends StatefulWidget {
  const Ewallet({Key? key}) : super(key: key);

  @override
  State<Ewallet> createState() => _EwalletState();
}

class _EwalletState extends State<Ewallet> {

  FirebaseAuth auth = FirebaseAuth.instance;
  bool _iswalletValid = false;
  final TextEditingController _walletController = TextEditingController();
  FocusNode _walletFocusNode = FocusNode();
  final _razorpay = Razorpay();
  dynamic val = 0;
  dynamic wallid = 0;
  int count = 0;


  Future<void> _updateWallet() async {
    print("Updating Wallet!!");
    final String updateUserMutation = '''
      mutation() {
        updateWallet(inputData: {
          balancenameId: "${wallid}"
          balance: "${(int.parse(_walletController.text.trim())+int.parse(val)).toString()}",   
        }) {
          balancename {
            id
            balance
          }
        }
      }

    ''';
    // final HttpLink httpLink = HttpLink(
    //     'http://192.168.43.12:8000/graphql/'); // Replace with your GraphQL API URL

    final GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    final MutationOptions options = MutationOptions(
      document: gql(updateUserMutation),
      // variables: {'id': userId},
      variables: {'id': wallid}
    );

    final QueryResult result = await client.mutate(options);

    if (result.hasException) {
      print('Error updating Wallet: ${result.exception.toString()}');
    } else {
      print('Wallet updated successfully');
    }
  }

  final String getIdQuery = r'''
    query ($fireid: String!){
      balancebyfireid(fireid: $fireid ) {
        id
        balance
      }
    }
  ''';

  // final String getBalanceQuery = r'''
  //   query ($useridval: String!){
  //     balancebyid(useridval: $useridval ) {
  //       balance
  //     }
  //   }
  // ''';

  Map<String, dynamic> datalist = {};
  // Map<String, dynamic> balancedatalist = {};

  final String userDeatil = r'''
    query ($fireid: String!){
      usersbyfireid(fireid: $fireid) {
        id
        username
        email
      }
    }
  ''';

  Map<String, dynamic> userdatalist = {};
  dynamic emailval ='';
  dynamic phoneno = '';



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
            'E-Wallet',
            style: GoogleFonts.poppins(
                color: Colors.black, fontSize: 20),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Query(
              options: QueryOptions(
                document: gql(userDeatil),
                // variables: {'id': NewAcountone.idvaluee},
                variables: {'fireid':fireid},

              ),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.hasException) {
                  print(result.exception.toString());
                  return Center(
                    child: Text(
                        'Error fetching UserName: ${result.exception.toString()}'),
                  );
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }

                userdatalist = result.data?['usersbyfireid'] ?? [];
                emailval = userdatalist['email'];
                phoneno = userdatalist['phoneno'];


                return Visibility(visible: false,child: Text("",style: GoogleFonts.poppins(fontWeight: FontWeight.w500,fontSize: 25,color: Colors.black),));
              },

            ),

            Query(
              options: QueryOptions(
                document: gql(getIdQuery),
                // variables: {'id': NewAcountone.idvaluee},
                variables: {'fireid':fireid},

              ),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.hasException) {
                  print(result.exception.toString());
                  return Center(
                    child: Text(
                        'Error fetching WalletId: ${result.exception.toString()}'),
                  );
                }

                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                  );
                }

                datalist = result.data?['balancebyfireid'] ?? [];
                wallid  = datalist['id'];


                return Visibility(visible: false,child: Text("₹"));
              },

            ),

            SvgPicture.asset("assets/images/e-wallet.svg",height: 350,),
            const SizedBox(height: 20,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                    child: Text(
                  "Account balance",
                  style: GoogleFonts.poppins(fontSize: 20),
                )),
              ],
            ),

            const SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.only(left: 30),

              child: Row(children: [
                Query(
                  options: QueryOptions(
                    document: gql(getIdQuery),
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
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.transparent,
                          backgroundColor: Colors.transparent,
                        ),
                      );
                    }

                    datalist = result.data?['balancebyfireid'] ?? [];
                    val  = datalist['balance'];


                    return Text("₹ ${val}",style: GoogleFonts.poppins(fontSize: 15),);
                  },

                ),

              ],),
            ),

            const SizedBox(height: 100,),

            Container(
              width: double.infinity,
              height: 45,
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context){
                        return SizedBox(
                          height: 450,
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
                                Container(
                                    padding: EdgeInsets.only(
                                      left: 5.5.w,
                                      right: 5.5.w,
                                    ),
                                    height: 7.0.h,
                                    child:
                                    // Note: Same code is applied for the TextFormField as well
                                    TextField(
                                      controller: _walletController,
                                      keyboardType: TextInputType.number,
                                      focusNode: _walletFocusNode,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.currency_rupee_rounded,
                                          color: _iswalletValid
                                              ? Colors.blueAccent.shade400
                                              : Colors.grey.shade600,
                                        ),
                                        hintText: "Add money",
                                        hintStyle: GoogleFonts.poppins(
                                            color: Colors.grey.shade600, fontSize: 12.sp),
                                        filled: true,
                                        fillColor: _iswalletValid
                                            ? Colors.blueAccent.shade200.withOpacity(0.2)
                                            : Colors.grey.shade600.withOpacity(0.2),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.0,
                                            color: _iswalletValid
                                                ? Colors.blueAccent.shade700
                                                : Colors.transparent,
                                          ),
                                          borderRadius: BorderRadius.circular(10.sp),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            width: 2.sp,
                                            color: Colors.blueAccent.shade400,
                                          ),
                                          borderRadius: BorderRadius.circular(10.sp),
                                        ),
                                      ),
                                    )),
                                 SizedBox(height: 20,),

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
                                        style: ElevatedButton.styleFrom(
                                            shape: const StadiumBorder(),
                                            backgroundColor:
                                            Colors.blueAccent.shade200.withOpacity(0.2),
                                            elevation: 0),
                                        child: Text(
                                          'Cancel',
                                          style: GoogleFonts.poppins(
                                              fontSize: 15, color: Colors.blueAccent.shade700),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 180,
                                      height: 45,
                                      padding: const EdgeInsets.only(left: 20, right: 20),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Navigator.pop(context);

                                          var options = {
                                            'key': 'rzp_test_srxx5ZiaXSlqeq',
                                            'amount':int.parse(_walletController.text.trim())*100,
                                            'name': 'Bepark',
                                            // 'order_id': 'order_EMBFqjDHEEn80l',
                                            'description': 'Ewallet Recharge',
                                            'prefill': {
                                              'contact': '9619191966',
                                              'email': '${emailval.toString()}'
                                            }
                                          };

                                          try{
                                            _razorpay.open(options);
                                          } on Exception catch(e){
                                            print("Error is : ${e}");
                                          }


                                        },
                                        style: ElevatedButton.styleFrom(
                                          shape: const StadiumBorder(),
                                          backgroundColor: Colors.blueAccent.shade700,
                                        ),
                                        child: Text(
                                          'Add',
                                          style: GoogleFonts.poppins(
                                              fontSize: 13, color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });

                },
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(),
                  backgroundColor: Colors.blueAccent.shade700,
                  elevation: 9,
                ),
                child: Text(
                  'Recharge Wallet',
                  style: GoogleFonts.poppins(fontSize: 15),
                ),
              ),
            ),

            // SizedBox(height: 20,),
            // Container(
            //   width: double.infinity,
            //   height: 45,
            //   padding: const EdgeInsets.only(left: 20, right: 20),
            //   child: ElevatedButton(
            //     onPressed: () {
            //       Get.offAll(SummaryPage());
            //     },
            //     style: ElevatedButton.styleFrom(
            //       shape: const StadiumBorder(),
            //       backgroundColor: Colors.blueAccent.shade700,
            //       elevation: 9,
            //     ),
            //     child: Text(
            //       'Go Back to booking',
            //       style: GoogleFonts.poppins(fontSize: 15),
            //     ),
            //   ),
            // ),




          ],
        ),

      ),
    );

  }

  @override
  void initState(){
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    _walletFocusNode.addListener(_handleEmailFocusChange);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    setState(() {
      count = 1;
      // val = val + int.parse(_walletController.text.trim());
    });
    _updateWallet();



    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.green.shade100,
        duration: const Duration(seconds: 6),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Payment Successful',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Payment has been sucessfully added to your Wallet',
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

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red.shade100,
        duration: Duration(seconds: 6),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Payment Failed',

              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Wallet Recharge Failed',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.red.shade400,
              ),
            ),
          ],
        ),
      ),
    );
    // _razorpay.clear(); // Removes all listeners
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.yellow.shade100,
        duration: Duration(seconds: 6),
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'External Wallet Used',

              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '${response.walletName} wallet was used for transaction',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.yellow.shade400,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _walletFocusNode.removeListener(_handleEmailFocusChange);
    _walletController.dispose();
    _razorpay.clear(); // Removes all listeners
    super.dispose();
  }

  void _handleEmailFocusChange() {
    if (_walletFocusNode.hasFocus != _iswalletValid) {
      setState(() {
        _iswalletValid = _walletFocusNode.hasFocus;
      });
    }
  }
}
