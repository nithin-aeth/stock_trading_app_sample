import 'package:flutter/material.dart';
import 'package:stock_trading_app/widgets/stock_graph.dart';

class CompanySharesScreen extends StatefulWidget {
  @override
  State<CompanySharesScreen> createState() => _CompanySharesScreenState();
}

class _CompanySharesScreenState extends State<CompanySharesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Company Shares',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Company Share History\n (Last 5 Years)',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ShareHistoryChart(),
              ],
            ),
          ),
        ],
      )
    );
  }
}
