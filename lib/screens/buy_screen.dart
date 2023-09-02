import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/screens/portfolio_screen.dart';

class BuyScreen extends StatefulWidget {
  @override
  _BuyScreenState createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController buyLimitController = TextEditingController();

  void _buyShares(BuildContext context) {
    int quantity = int.tryParse(quantityController.text) ?? 0;
    double price = double.tryParse(priceController.text) ?? 0.0;
    double buyLimit = double.tryParse(buyLimitController.text) ?? 0.0;

    if (quantity <= 0 || price <= 0.0 || buyLimit <= 0.0) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Invalid Input'),
            content: const Text('Please enter valid quantity, price, and buy limit.'),
            actions: [
              TextButton(onPressed: () {Navigator.of(context).pop();
                },
                child: const Text('OK'),
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
        buyLimit: buyLimit,
        type: TransactionType.buy,
        sellLimit: 0.0,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buy Shares'),
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
              controller: buyLimitController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Buy Limit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {_buyShares(context);},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
