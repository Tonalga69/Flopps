import 'package:fl_chart/fl_chart.dart';
import 'package:flopps/utils/ProjectColors.dart';
import 'package:flopps/utils/Strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SleepTrackerChart extends StatelessWidget {
  const SleepTrackerChart({super.key, required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      isShowingMainData ? sleepingHours : snoring,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get sleepingHours => LineChartData(
        lineTouchData: lineTouchDataSleepingHours,
        gridData: gridData,
        titlesData: titlesSleepingHours,
        borderData: borderData,
        lineBarsData: lineBarsSleepingHours,
        minX: 0.5,
        maxX: 7,
        maxY: 24,
        minY: 1,
      );

  LineChartData get snoring => LineChartData(
        lineTouchData: lineSnoringTouchData,
        gridData: gridData,
        titlesData: titlesData2,
        borderData: borderData,
        lineBarsData: lineBarsData2,
        minX: 0.5,
        maxX: 7,
        maxY: 100,
        minY: 1,
      );

  LineTouchData get lineTouchDataSleepingHours => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
            tooltipBgColor:
                const Color(ProjectColors.grayBackground).withOpacity(0.9),
            getTooltipItems: getLineToolTipItems),
      );

  List<LineTooltipItem> getLineToolTipItems(List<LineBarSpot> barSpot) {
    return barSpot.map((touchedSpot) {
      String text = "";
      final textStyle = TextStyle(
        color: touchedSpot.bar.gradient?.colors.first ??
            touchedSpot.bar.color ??
            Colors.blueGrey,
        fontWeight: FontWeight.bold,
        fontSize: 14,
      );
      if (touchedSpot.bar.color == Colors.green) {
        text = Strings.awakeHours;
      }
      if (touchedSpot.bar.color == Colors.pink.shade700) {
        text = Strings.sleepingHours;
      }
      if (touchedSpot.bar.color == const Color(ProjectColors.strongBlue)) {
        text = Strings.averageSleepingHours;
      }

      return LineTooltipItem("${touchedSpot.y} $text", textStyle);
    }).toList();
  }

  FlTitlesData get titlesSleepingHours => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsSleepingHours => [
        lineChartAverangeSleepingHours,
        lineChartSleepingHours,
        lineChartAwakeHours,
      ];

  LineTouchData get lineSnoringTouchData => LineTouchData(
        enabled: true,
    handleBuiltInTouches: true
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData2 => [
        lineChartAverageSnoring,
        lineChartSnoringTimes,
        lineChartSnoringLastWeek,
      ];

  Widget leftTitleWidgetsSleepingHours(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        fontFamily: FontFamily.sourceSansPro,
        color: Color(ProjectColors.white));
    String text;
    switch (value.toInt()) {
      case 2:
        text = '2H';
        break;

      case 4:
        text = '4H';
        break;

      case 6:
        text = '6H';
        break;
      case 8:
        text = '8H';
        break;

      case 10:
        text = '10H';

        break;

      case 12:
        text = '12H';
        break;

      case 14:
        text = '14H';
        break;

      case 16:
        text = '16H';
        break;
      case 18:
        text = '18H';
        break;

      case 20:
        text = '20H';
        break;

      case 22:
        text = '22H';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  Widget leftTitleWidgetsSnoring(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        fontFamily: FontFamily.sourceSansPro,
        color: Color(ProjectColors.white));
    String text;
    switch (value.toInt()) {
      case 20:
        text = '20';
        break;

      case 40:
        text = '40';
        break;

      case 60:
        text = '60';
        break;
      case 80:
        text = '80';
        break;

      case 100:
        text = '100';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: isShowingMainData
            ? leftTitleWidgetsSleepingHours
            : leftTitleWidgetsSnoring,
        showTitles: true,
        interval: 1,
        reservedSize: 35,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 12,
        color: Color(ProjectColors.lightBlue));
    Widget text;
    switch (value.toInt()) {
      case 1:
        text = const Text('Mon', style: style);
        break;
      case 2:
        text = const Text('Tue', style: style);
        break;
      case 3:
        text = const Text('Wed', style: style);
        break;
      case 4:
        text = const Text('Thu', style: style);
        break;
      case 5:
        text = const Text('Fri', style: style);
        break;
      case 6:
        text = const Text('Sat', style: style);
        break;
      case 7:
        text = const Text('Sun', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(color: Colors.cyan.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartAverangeSleepingHours => LineChartBarData(
        isCurved: true,
        color: const Color(ProjectColors.strongBlue),
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 7),
          FlSpot(2, 8),
          FlSpot(3, 4),
          FlSpot(4, 13),
          FlSpot(5, 7),
          FlSpot(6, 6),
          FlSpot(7, 7),
        ],
      );

  LineChartBarData get lineChartSleepingHours => LineChartBarData(
        isCurved: true,
        color: Colors.pink.shade700,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: Colors.pink.withOpacity(0),
        ),
        spots: const [
          FlSpot(1, 8),
          FlSpot(2, 6),
          FlSpot(3, 5),
          FlSpot(4, 6),
          FlSpot(5, 7),
          FlSpot(6, 8),
          FlSpot(7, 8),
        ],
      );

  LineChartBarData get lineChartAwakeHours => LineChartBarData(
        isCurved: true,
        color: Colors.green,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 16),
          FlSpot(2, 18),
          FlSpot(3, 19),
          FlSpot(4, 18),
          FlSpot(5, 17),
          FlSpot(6, 16),
          FlSpot(7, 16),
        ],
      );

  LineChartBarData get lineChartAverageSnoring => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color(ProjectColors.strongBlue),
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 70),
          FlSpot(2, 70),
          FlSpot(3, 70),
          FlSpot(4, 70),
          FlSpot(5, 70),
          FlSpot(6, 70),
          FlSpot(7, 70),
        ],
      );

  LineChartBarData get lineChartSnoringTimes => LineChartBarData(
        isCurved: true,
        color: Colors.pink.shade700,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(
          show: true,
          color: Colors.pink.withOpacity(0.2),
        ),
        spots: const [
          FlSpot(1, 80),
          FlSpot(2, 60),
          FlSpot(3, 50),
          FlSpot(4, 60),
          FlSpot(5, 70),
          FlSpot(6, 80),
          FlSpot(7, 80),
        ],
      );

  LineChartBarData get lineChartSnoringLastWeek => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData:
            BarAreaData(show: true, color: Colors.green.withOpacity(0.2)),
        spots: const [
          FlSpot(1, 60),
          FlSpot(2, 35),
          FlSpot(3, 60),
          FlSpot(4, 66),
          FlSpot(5, 50),
          FlSpot(6, 10),
          FlSpot(7, 20),
        ],
      );
}

class SleepTrackerChartMain extends StatefulWidget {
  const SleepTrackerChartMain({super.key});

  @override
  State<StatefulWidget> createState() => SleepTrackerChartMainState();
}

class SleepTrackerChartMainState extends State<SleepTrackerChartMain> {
  late bool isShowingMainData;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(ProjectColors.darkBackground),
          borderRadius: BorderRadius.circular(15)),
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const SizedBox(
                  height: 37,
                ),
                Text(
                  isShowingMainData ? 'Hours of sleep' : "snoring",
                  style: const TextStyle(
                    color: Color(ProjectColors.white),
                    fontSize: 24,
                    fontFamily: FontFamily.sourceSansPro,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 37,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, left: 6),
                    child:
                        SleepTrackerChart(isShowingMainData: isShowingMainData),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.arrowsRotate,
                color: const Color(ProjectColors.strongBlue)
                    .withOpacity(isShowingMainData ? 1.0 : 0.5),
              ),
              onPressed: () {
                setState(() {
                  isShowingMainData = !isShowingMainData;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
