import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_guardian/styling/colors.dart';

class BarChartExample extends StatefulWidget {
  @override
  _BarChartExampleState createState() => _BarChartExampleState();
}

class _BarChartExampleState extends State<BarChartExample> {
  int? tappedGroupIndex; // To track which bar group is clicked
  double? tappedRodValue; // To store the value of the clicked rod

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15, left: 5),
          child: Stack(
            alignment: Alignment.center,
            children: [
              BarChart(
                BarChartData(
                  barGroups: [
                    _buildBarGroup(0, 104, 62),
                    _buildBarGroup(1, 116, 65),
                    _buildBarGroup(2, 108, 64),
                    _buildBarGroup(3, 99, 60),
                    _buildBarGroup(4, 105, 63),
                    _buildBarGroup(5, 101, 68),
                  ],
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 35,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() % 20 == 0) {
                            return Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                color: Color.fromARGB(255, 59, 56, 56),
                                fontFamily: "CoreSansBold",
                                fontSize: 16,
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: false),
                  barTouchData: BarTouchData(
                    touchTooltipData: BarTouchTooltipData(
                      getTooltipColor: (group) {
                        return Colors.transparent;
                      },
                      tooltipPadding: EdgeInsets.zero,
                      getTooltipItem: (group, groupIndex, rod, rodIndex) =>
                          null,
                    ),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          tappedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                          tappedRodValue =
                              response.spot!.touchedRodData.toY; // Get value
                        });
                      } else {
                        setState(() {
                          tappedGroupIndex = null;
                          tappedRodValue = null;
                        });
                      }
                    },
                  ),
                ),
              ),
              if (tappedRodValue != null)
                Positioned(
                  top:200,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30,
                    child: Text(
                      '${tappedRodValue!.toStringAsFixed(1)}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          width: 20,
          borderRadius: BorderRadius.circular(10),
          color: Colours.buttonColorRed,
        ),
        BarChartRodData(
          toY: y2,
          width: 20,
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.withOpacity(0.2),
        ),
      ],
    );
  }
}
