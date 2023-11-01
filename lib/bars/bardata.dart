import 'package:sem5demo3/bars/indivibar.dart';

class Bardata{
  final double suntime;
  final double montime;
  final double tuetime;
  final double wedtime;
  final double thutime;
  final double fritime;
  final double sattime;

  Bardata({
    required this.suntime,
    required this.montime,
    required this.tuetime,
    required this.wedtime,
    required this.thutime,
    required this.fritime,
    required this.sattime,

  });

  List<IndividualBar> barData = [];

  void initializeBardata() {
    barData  = [
    IndividualBar(x: 0,y: suntime),
    IndividualBar(x: 1,y: montime),
    IndividualBar(x: 2,y: tuetime),
    IndividualBar(x: 3,y: wedtime),
    IndividualBar(x: 4,y: thutime),
    IndividualBar(x: 5,y: fritime),
    IndividualBar(x: 6,y: sattime),
    ];

  }

}