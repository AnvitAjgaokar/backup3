
import 'package:get/get.dart';
import 'package:sem5demo3/authentication/auth_controller.dart';
import 'package:sem5demo3/bookingdetail.dart';



class OTPController extends GetxController {
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.insatnce.verifyOTP(otp);
    isVerified ? Get.offAll(BookingDetails()) : Get.back();
  }


}