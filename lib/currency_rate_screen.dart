import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CurrencyRateScreen extends StatefulWidget {
  @override
  _CurrencyRateScreenState createState() => _CurrencyRateScreenState();
}

class _CurrencyRateScreenState extends State<CurrencyRateScreen> {
  final String apiKey = '137dc328c9a4770944e19d93acabd250';
  Map<String, dynamic>? rates;
  String lastUpdated = '';
  String timestamp = '';

  @override
  void initState() {
    super.initState();
    fetchRates();
  }

  Future<void> fetchRates() async {
    final response = await http.get(
      Uri.parse('https://data.fixer.io/api/latest?access_key=$apiKey'),
    );

    setState(() {
      // Update timestamp with the current time every time fetchRates is called
      timestamp = DateTime.now().toLocal().toString();
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Update the state with the new rates and date from the API
      setState(() {
        rates = data['rates'];
        lastUpdated = data['date'];

        // If you still want to show the API-provided timestamp, uncomment the lines below:
        // int unixTimestamp = data['timestamp'];
        // DateTime apiDate = DateTime.fromMillisecondsSinceEpoch(unixTimestamp * 1000);
        // timestamp = apiDate.toLocal().toString();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load exchange rates')),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Live Rate'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchRates,
          ),
        ],
      ),
      body: rates == null
          ? Center(child: CircularProgressIndicator())
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Base Currency: EUR\n'
                  'Last Updated: $lastUpdated\n'
                  'Timestamp: $timestamp',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: rates!.keys.length,
              itemBuilder: (context, index) {
                String currency = rates!.keys.elementAt(index);
                double rate = rates![currency].toDouble();

                return ListTile(
                  title: Text(currency),
                  subtitle: Text('Rate: $rate'),
                  onTap: () {
                    // Navigate to Currency Conversion Screen with arguments using named routes
                    Navigator.pushNamed(
                      context,
                      '/currencyConversion',
                      arguments: {'currency': currency, 'rate': rate},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
