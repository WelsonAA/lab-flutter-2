import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Currency Changing App'),
        backgroundColor: Colors.red,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('WELCOME TO CONVERTER APP', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Icon(Icons.currency_exchange, size: 100),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/currencyRate');
              },
              child: Text('Choose your Currency'),
            ),
          ],
        ),
      ),
    );
  }
}
