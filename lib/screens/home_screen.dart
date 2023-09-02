import 'dart:math';
import 'package:flutter/material.dart';
import 'package:stock_trading_app/screens/CompanyShareScreen.dart';
import 'package:stock_trading_app/screens/portfolio_screen.dart';
import 'dart:async';

import 'package:stock_trading_app/widgets/real_time_stock.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double stockPrice = 0.0;
  String priceChange = "+0.00%";
  late Timer dataUpdateTimer;

  @override
  void initState() {
    super.initState();
    startDataUpdateTimer();
  }

  void startDataUpdateTimer() {
    dataUpdateTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      fetchRealTimeData();
    });
  }

  void fetchRealTimeData() {
    final newStockPrice = 150.25 + (0.5 - (Random().nextDouble())) * 10; // Simulated price change
    final priceDifference = newStockPrice - stockPrice;
    final priceChangePercentage = (priceDifference / stockPrice) * 100;
    setState(() {
      stockPrice = newStockPrice;
      priceChange = (priceDifference >= 0 ? '+' : '') + priceChangePercentage.toStringAsFixed(2) + '%';
    });
  }

  @override
  void dispose() {
    dataUpdateTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title:const  Text('Stock Trading App',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildBody() {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 75),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              const SizedBox(height: 35),
              buildStockPrice(),
              const SizedBox(height: 25,),
              buildPriceChange(),
              const SizedBox(height: 40),
              const SizedBox(height: 150),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildViewPortfolioButton(),
                  const SizedBox(width: 10,),
                  buildViewCompanySharesButton(),
                ],
              ),
              const SizedBox(height: 25,),
              Center(child: realTimeGraph())
            ],
          ),
        ),
      ],
    );
  }
  ElevatedButton buildViewCompanySharesButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CompanySharesScreen()),);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      ),
      child: const Text(
        'View Share Graph',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
    );
  }

  ElevatedButton realTimeGraph() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => RealTimeStockChart(),),);},
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 16),
        backgroundColor: Colors.red,
      ),
      child: const Text('Real-Time Stock Chart'),
    );
  }


  Text buildTitle() {
    return const Text('Live Stock Updates.',
      style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Row buildStockPrice() {
    return Row(
      children: [
        const Text('Stock Price - ',
          style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
        ),
        const SizedBox(width:15,),
        Text(
          '\$${stockPrice.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.green),
        ),
      ],
    );
  }

  Row buildPriceChange() {
    return Row(
      children: [
        const Text('Price Change -',
          style: TextStyle(fontSize: 18, color: Colors.white,fontWeight: FontWeight.bold),
        ),
        const SizedBox(width:15,),
        Text(
          priceChange,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: priceChange.startsWith('-') ? Colors.red : Colors.green,
          ),
        ),
      ],
    );
  }


  ElevatedButton buildViewPortfolioButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PortfolioScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: const Text('View Portfolio', style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
      ),
    );
  }
}

