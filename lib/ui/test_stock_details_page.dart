import 'package:flutter/material.dart';
import 'package:stock_easy/models/best_matches_stock_item.dart';
import 'package:stock_easy/ui/providers/inherit_model_stock_provider.dart';
import 'package:stock_easy/ui/providers/inherit_widget_stock_provider.dart';

class TestStockDetailsPage extends StatefulWidget {
  final Stock stock;

  TestStockDetailsPage({@required this.stock});

  @override
  State<StatefulWidget> createState() {
    return TestStockDetailsPageState();
  }
}

class TestStockDetailsPageState extends State<TestStockDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DependentAppBarTitle(),
      ),
      body: StockModelProvider(
        stock: widget.stock,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              DependentWidgetOne(),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    widget.stock.name = 'Onmobile';
                  });
                },
              ),
              StockWidgetProvider(
                stock: widget.stock,
                child: DependentWidgetTwo(),
              ),
              RaisedButton(
                onPressed: () {
                  setState(() {
                    widget.stock.type = 'Bombay Exchange';
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DependentAppBarTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Details',
      style: TextStyle(
        fontSize: 22.0,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

class DependentWidgetOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ancestor = StockModelProvider.of(context, 'stock');
    return Container(
      height: 150,
      width: 200,
      child: Center(
        child: Text(
          ancestor.stock.name + '-' + ancestor.stock.type,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DependentWidgetTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ancestor = StockWidgetProvider.of(context);
    return Container(
      height: 150,
      width: 200,
      child: Center(
        child: Text(
          ancestor.stock.name + '-' + ancestor.stock.type,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
