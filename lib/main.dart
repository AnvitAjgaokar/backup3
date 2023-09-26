import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:sem5demo3/authentication/auth_controller.dart';
import 'package:sem5demo3/firebase_options.dart';
import 'package:sem5demo3/onboarding/onboardingscreen.dart';
import 'package:sem5demo3/sign%20_in_up/usercheck.dart';
import 'package:sizer/sizer.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: UserCheck(),
          // darkTheme: ThemeData(brightness: Brightness.dark),
          // theme: ThemeData(brightness: Brightness.light),
          // themeMode: ThemeMode.system,
          // themeMode: ThemeMode.system,
          // darkTheme: ThemeData.dark(),
          // theme: ThemeData.light(),
        );
      },

    );
  }
}
