import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class RealTimeStockChart extends StatefulWidget {
  @override
  _RealTimeStockChartState createState() => _RealTimeStockChartState();
}

class _RealTimeStockChartState extends State<RealTimeStockChart> {
  StreamController<double> stockPriceStreamController =
  StreamController<double>();
  double currentStockPrice = 100.0;
  List<FlSpot> stockPriceData = [];

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 2), (timer) {
      currentStockPrice += (0.5 - (DateTime.now().second % 2)) * 2.0;
      stockPriceData.add(FlSpot(stockPriceData.length.toDouble(), currentStockPrice));
      stockPriceStreamController.sink.add(currentStockPrice);
      setState(() {});
    });
  }

  @override
  void dispose() {
    stockPriceStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Real-Time Stock Chart'),
      ),
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding:  EdgeInsets.all(15.0),
                child: Text('Real-Time Stock Price Graph',
                  style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 150,),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,
                height: 200.0,
                child: LineChart(
                  LineChartData(
                    gridData: const  FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: stockPriceData.length.toDouble(),
                    minY: 0,
                    maxY: 200.0,
                    lineBarsData: [
                      LineChartBarData(
                        spots: stockPriceData,
                        isCurved: true,
                        color: Colors.green,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
