
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sem5demo3/bookingdetail.dart';
import 'package:sem5demo3/sign%20_in_up/signup.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get insatnce => Get.find();

  // variables
  final _auth = FirebaseAuth.instance;

  late final Rx<User?> firebaseUser;
  var verificationId = ''.obs;

  @override
  void onReady(){
    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    // ever(firebaseUser, _setInitialScreen);
  }

  // _setInitialScreen(User? user){
  //   user == null ? Get.offAll(() => const SignUpFormWidget()) : Get.offAll(() => const BookingDetails());
  // }

  void phoneAuthentication(String phoneNo) async{
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phoneNo',
      verificationCompleted: (credential) async{
        await _auth.signInWithCredential(credential);
      },

      codeSent: (verificationId, resendToken){
        this.verificationId.value = verificationId;

      },
      codeAutoRetrievalTimeout: (verificationId){
        this.verificationId.value = verificationId;
      },

      verificationFailed: (e){
        if (e.code == 'invalid-phone-number'){
          Get.snackbar('Error', 'The provided phone number is not valid');
        }
        else{
          Get.snackbar('Error', 'Something went wrong!!');
        }

      },
    );

  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: this.verificationId.value,
        smsCode: otp));
    return credentials.user != null ? true : false;

  }

  Future<void> logout() async => await _auth.signOut();


}