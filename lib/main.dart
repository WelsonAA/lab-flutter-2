import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'currency_rate_screen.dart';
import 'currency_conversion_screen.dart';

void main() {
  runApp(CurrencyApp());
}

class CurrencyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Currency Changing App',
      theme: ThemeData(primarySwatch: Colors.orange),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/currencyRate': (context) => CurrencyRateScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/currencyConversion') {
          final args = settings.arguments as Map<String, dynamic>;
          return MaterialPageRoute(
            builder: (context) {
              return CurrencyConversionScreen(
                currency: args['currency'] as String,
                rate: args['rate'] as double,
              );
            },
          );
        }
        assert(false, 'Need to implement ${settings.name}');
        return null;
      },
    );
  }
}
