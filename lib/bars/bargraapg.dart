import 'package:button_widget/button_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sem5demo3/bars/bardata.dart';

class MyBargraph extends StatelessWidget {

  final List weeklySummary;
  MyBargraph({
    super.key,
    required this.weeklySummary
});

  @override
  Widget build(BuildContext context) {
    Bardata myBarData = Bardata(suntime:  weeklySummary[0],
        montime: weeklySummary[1],
        tuetime:  weeklySummary[2],
        wedtime:  weeklySummary[3],
        thutime:  weeklySummary[4],
        fritime:  weeklySummary[5],
        sattime:  weeklySummary[6],);

    myBarData.initializeBardata();
    return BarChart(
      BarChartData(
        maxY: 12,
        minY: 0,

          gridData: FlGridData(show: false),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            show: true,
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false
              )
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false
              )
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getBottomtiles
              )
            )
          ),
          barGroups: myBarData.barData.map((data) =>
              BarChartGroupData(
                x: data.x,
                  barRods: [
                    BarChartRodData(
                        toY: data.y,
                        color: Colors.blueAccent.shade700,
                      width: 15,
                      borderRadius: BorderRadius.circular(10),
                      backDrawRodData: BackgroundBarChartRodData(
                        show: true,
                        toY: 12,
                        color: Colors.grey.shade200
                      )
                    )
                  ]
              ),

          ).toList(),

      )
    );
  }
}

Widget getBottomtiles(double value,TitleMeta meta ){

   Widget text;
   switch (value.toInt()){
     case 0:
       text =  Text('S', style: GoogleFonts.poppins(
       fontWeight: FontWeight.bold,
           fontSize: 12,));
       break;

     case 2:
       text =  Text('M', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;

     case 2:
       text =  Text('T', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;

     case 3:
       text =  Text('W', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;

     case 4:
       text =  Text('T', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;

     case 5:
       text =  Text('F', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;

     case 6:
       text =  Text('S', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;

     default:
       text =  Text('S', style: GoogleFonts.poppins(
         fontWeight: FontWeight.bold,
         fontSize: 12,));
       break;


   }
   return SideTitleWidget(child: text, axisSide: meta.axisSide);
}