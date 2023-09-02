import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/screens/portfolio_screen.dart';

class SellScreen extends StatefulWidget {
  @override
  _SellScreenState createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController sellLimitController = TextEditingController();

  void _sellShares(BuildContext context) {
    int quantity = int.tryParse(quantityController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0.0;
    double sellLimit = double.tryParse(sellLimitController.text) ?? 0.0;

    if (quantity <= 0 || price <= 0.0 || sellLimit <= 0.0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter valid quantity, price, and sell limit.'),
            actions: [
              TextButton(onPressed: () {Navigator.of(context).pop();},
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    final portfolioProvider = Provider.of<PortfolioProvider>(context, listen: false);
    portfolioProvider.addTransaction(
      PortfolioItem(
        symbol: 'AAPL',
        quantity: quantity,
        purchasePrice: price,
        sellLimit: sellLimit,
        type: TransactionType.sell,
        buyLimit: 0.0,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Sell Shares'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Price per Share'),
            ),
            TextField(
              controller: sellLimitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Sell Limit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () {_sellShares(context);},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Sell'),
            ),
          ],
        ),
      ),
    );
  }
}

