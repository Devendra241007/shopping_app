import 'package:flutter/material.dart';

class PaymentScreen extends StatelessWidget {
  final double total;

  const PaymentScreen({required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Card Number")),
            TextField(decoration: InputDecoration(labelText: "Expiry Date")),
            TextField(decoration: InputDecoration(labelText: "CVV")),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Pay ₹$total"),
            )
          ],
        ),
      ),
    );
  }
}