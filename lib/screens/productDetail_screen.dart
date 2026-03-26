import 'package:flutter/material.dart';

class ProductDetailScreen extends StatefulWidget {
  final dynamic product;

  const ProductDetailScreen({required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {

  int quantity = 1;
  int selectedSize = 0;
  int selectedColor = 0;

  List sizes = ["S", "M", "L", "XL"];
  List colors = [Colors.grey, Colors.brown, Colors.black];

  @override
  Widget build(BuildContext context) {
    int price = widget.product['price'] ?? 0;
    int totalPrice = price * quantity;
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),

      body: SafeArea(
        child: Column(
          children: [

            // 🔥 IMAGE WITH BUTTONS
            Stack(
              children: [
                Container(
                  margin: EdgeInsets.all(16),
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Image.network(
                      widget.product['image'],
                      fit: BoxFit.cover,
                      width: double.infinity,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.image_not_supported, size: 50),
                        );
                      },
                    ),
                  ),
                ),

                // BACK BUTTON
                Positioned(
                  top: 30,
                  left: 30,
                  child: circleIcon(Icons.arrow_back, () {
                    Navigator.pop(context);
                  }),
                ),

                // WISHLIST
                Positioned(
                  top: 30,
                  right: 30,
                  child: circleIcon(Icons.favorite_border, () {}),
                ),
              ],
            ),

            // 🔥 DETAILS
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // NAME + QUANTITY
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.product['name'],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Row(
                          children: [
                            qtyButton(Icons.remove, () {
                              if (quantity > 1) {
                                setState(() => quantity--);
                              }
                            }),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("$quantity"),
                            ),
                            qtyButton(Icons.add, () {
                              setState(() => quantity++);
                            }),
                          ],
                        )
                      ],
                    ),

                    SizedBox(height: 10),

                    // ⭐ RATING
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.orange, size: 18),
                        SizedBox(width: 5),
                        Text("5.0 (732 reviews)"),
                      ],
                    ),

                    SizedBox(height: 10),

                    // DESCRIPTION
                    Text(
                      widget.product['longDescription'] ?? "No description available",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Read More...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: 20),

                    // SIZE
                    Text("Choose Size", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    Row(
                      children: List.generate(sizes.length, (index) {
                        bool selected = selectedSize == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedSize = index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: selected ? Colors.black : Colors.grey[200],
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              sizes[index],
                              style: TextStyle(
                                color: selected ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    SizedBox(height: 20),

                    // COLOR
                    Text("Color", style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),

                    Row(
                      children: List.generate(colors.length, (index) {
                        bool selected = selectedColor == index;

                        return GestureDetector(
                          onTap: () {
                            setState(() => selectedColor = index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 10),
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: colors[index],
                              shape: BoxShape.circle,
                              border: selected
                                  ? Border.all(color: Colors.black, width: 2)
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ),

                    Spacer(),

                    // 🔥 ADD TO CART BUTTON
                    Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Color(0xFF2D2A2A),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Add to Cart | ₹$totalPrice",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget circleIcon(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(icon),
      ),
    );
  }

  Widget qtyButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}