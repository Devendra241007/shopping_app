import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  final List cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  Map quantities = {};

  @override
  void initState() {
    super.initState();

    for (var item in widget.cart) {
      quantities[item] = 1;
    }
  }

  @override
  Widget build(BuildContext context) {

    double total = 0;

    widget.cart.forEach((item) {
      total += (item['price'] * quantities[item]);
    });

    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text("Checkout", style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.black),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [

            // 🔥 CART LIST
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {

                  final p = widget.cart[index];

                  return Container(
                    margin: EdgeInsets.only(bottom: 15),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      children: [

                        // IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            p['image'],
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          ),
                        ),

                        SizedBox(width: 10),

                        // DETAILS
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p['name'],
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Text(
                                p['shortDescription'] ?? "",
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "₹${p['price']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),

                        // QUANTITY
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantities[p] > 1) {
                                    quantities[p]--;
                                  }
                                });
                              },
                            ),

                            Text("${quantities[p]}"),

                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantities[p]++;
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // 🔥 SHIPPING
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Icon(Icons.credit_card),
                  SizedBox(width: 10),
                  Text("Visa **** 2143"),
                  Spacer(),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),

            SizedBox(height: 20),

            // 🔥 TOTAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total (${widget.cart.length} items)"),
                Text("₹${total.toInt()}"),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Fee"),
                Text("₹0"),
              ],
            ),

            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Discount"),
                Text("₹0"),
              ],
            ),

            Divider(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sub Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "₹${total.toInt()}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),

            SizedBox(height: 20),

            // 🔥 PAY BUTTON
            Container(
              width: double.infinity,
              height: 55,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "Pay",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}