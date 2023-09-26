import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sem5demo3/main/mainpage.dart';
import 'package:sem5demo3/newaccount.dart';
import 'package:sem5demo3/sign%20_in_up/newacc.dart';
import 'package:sem5demo3/sign%20_in_up/signin.dart';
import 'package:sem5demo3/sign%20_in_up/usercheck.dart';


class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(bottom: 30),
          child: IntroductionScreen(
            pages: [
              PageViewModel(
                image: SvgPicture.asset('assets/images/onbsvg1.svg'),
                title: 'Find Parking Places Around You Easily',
                body:
                    'Find nearby parking easily with our convenient, user-friendly, and efficient solution.',
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                // image: buildImage('assets/images/secononcop.jpg'),
                image: SvgPicture.asset('assets/images/onbsvg2.svg'),

                title: 'Book and Pay Parking Quickly & Easily ',
                body:
                    'Effortlessly book and pay for parking spaces swiftly with our user-friendly platform.',
                decoration: getPageDecoration(),
              ),
              PageViewModel(
                image: SvgPicture.asset('assets/images/onbsvg3.svg'),
                title: 'Select Parking Time As You Need',
                body:
                    'Take control of your parking schedule with our flexible and user-friendly system. Easily customize and select your desired parking time effortlessly.',
                decoration: getPageDecoration(),
              ),
            ],
            showSkipButton: true,
            skip: Text('Skip',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent.shade700)),
            onSkip: () => Get.to(() => UserCheck(),
                transition: Transition.cupertinoDialog, duration: Duration(seconds: 1)),
            done: Text('Done',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent.shade700)),
            onDone: () => Get.to(() => UserCheck(),
                transition: Transition.cupertinoDialog, duration: Duration(seconds: 1)),
            showNextButton: false,
            dotsDecorator: getDotDecoration(),
            onChange: (index) => print('Page $index selected'),
            dotsFlex: 2,
            globalBackgroundColor: Colors.white,
          ),
        ),
      );

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 350));

  DotsDecorator getDotDecoration() => DotsDecorator(
        color: Colors.blue.shade100,
        activeColor: Colors.blueAccent.shade700,
        // size: Size(10, 10),
      );

  PageDecoration getPageDecoration() => PageDecoration(
        titleTextStyle:
            GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
        bodyTextStyle: GoogleFonts.poppins(fontSize: 14),
        bodyPadding: EdgeInsets.only(left: 5, right: 5),
        imagePadding: EdgeInsets.all(20),
        imageFlex: 2,
        pageColor: Colors.white,
      );
}
