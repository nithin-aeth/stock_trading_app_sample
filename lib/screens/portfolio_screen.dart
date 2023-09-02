import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_trading_app/screens/buy_screen.dart';
import 'package:stock_trading_app/screens/sell_screen.dart';

enum TransactionType { buy, sell }

class PortfolioItem {
  final String symbol;
  final int quantity;
  final double purchasePrice;
  final TransactionType type;
  final double buyLimit;
  final double sellLimit;

  PortfolioItem(
      {required this.symbol,
      required this.quantity,
      required this.purchasePrice,
      required this.type,
      required this.buyLimit,
      required this.sellLimit});
}

class PortfolioProvider extends ChangeNotifier {
  List<PortfolioItem> _portfolioItems = [];

  List<PortfolioItem> get portfolioItems => _portfolioItems;

  void addTransaction(PortfolioItem item) {
    _portfolioItems.add(item);
    notifyListeners();
  }
}

class PortfolioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortfolioProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Portfolio'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Your Portfolio',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50.0),
            if (portfolioProvider.portfolioItems.isEmpty)
              const Center(
                child: Text(
                  'Your portfolio is empty.',
                  style: TextStyle(fontSize: 14.0),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: portfolioProvider.portfolioItems.length,
                  itemBuilder: (context, index) {
                    final item = portfolioProvider.portfolioItems[index];
                    if (item.type == TransactionType.buy) {
                      return BuyPortfolioItemWidget(item: item);
                    } else if (item.type == TransactionType.sell) {
                      return SellPortfolioItemWidget(item: item);
                    }
                    return Container();
                  },
                ),
              ),
            const SizedBox(height: 50.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BuyScreen(),),);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green,
                  ),
                  child: const Text('Buy Shares'),
                ),
                ElevatedButton(
                  onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SellScreen(),),);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('Sell Shares'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BuyPortfolioItemWidget extends StatelessWidget {
  final PortfolioItem item;

  BuyPortfolioItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_upward, color: Colors.green),
      title: Text(item.symbol),
      subtitle: Text('Quantity: ${item.quantity}'),
      trailing:
          Text('Purchase Price: \$${item.purchasePrice.toStringAsFixed(2)}'),
    );
  }
}

class SellPortfolioItemWidget extends StatelessWidget {
  final PortfolioItem item;

  SellPortfolioItemWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_downward, color: Colors.red),
      title: Text(item.symbol),
      subtitle: Text('Quantity: ${item.quantity}'),
      trailing:
          Text('Purchase Price: \$${item.purchasePrice.toStringAsFixed(2)}'),
    );
  }
}
