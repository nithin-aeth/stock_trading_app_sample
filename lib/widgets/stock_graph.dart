import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ShareHistoryChart extends StatelessWidget {
  final List<FlSpot> shareData = [
    FlSpot(0, 100),
    FlSpot(1, 120),
    FlSpot(2, 90),
    FlSpot(3, 110),
    FlSpot(4, 120),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 350,
      width: double.infinity,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: true),
          minX: 0,
          maxX: 4,
          minY: 0,
          maxY: 150,
          lineBarsData: [
            LineChartBarData(
              spots: shareData,
              isCurved: true,
              color: Colors.green,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(show: true),
            ),
          ],
        ),
      ),
    );
  }
}
