import 'package:flutter/material.dart';

class CurrencyConversionScreen extends StatefulWidget {
  final String currency;
  final double rate;

  const CurrencyConversionScreen({
    Key? key,
    required this.currency,
    required this.rate,
  }) : super(key: key);

  @override
  _CurrencyConversionScreenState createState() => _CurrencyConversionScreenState();
}

class _CurrencyConversionScreenState extends State<CurrencyConversionScreen> {
  final TextEditingController _controller = TextEditingController();
  double? convertedAmount;

  void convertCurrency() {
    double amount = double.tryParse(_controller.text) ?? 0;
    setState(() {
      convertedAmount = amount * widget.rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Convert from Euro to ${widget.currency}'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount in Euro'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertCurrency,
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            convertedAmount == null
                ? Container()
                : Text(
              '${_controller.text} EUR = $convertedAmount ${widget.currency}',
              style: TextStyle(fontSize: 18),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
