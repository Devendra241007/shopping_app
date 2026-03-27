import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screens/productDetail_screen.dart';
import 'package:shopping_app/screens/wishlist.dart';

import '../services/api_services.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("name") ?? "User";
      email = prefs.getString("email") ?? "No email";
    });
  }

  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),

      body: SafeArea(
        child: FutureBuilder(
          future: ApiService.getProducts(),
          builder: (context, snapshot) {

            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(color: Color(0xFFFF6F61),));
            }

            List products = snapshot.data!;

            // 🔥 FILTER
            List filtered = selectedCategory == "All"
                ? products
                : products.where((p) =>
            p['category'].toLowerCase() ==
                selectedCategory.toLowerCase()).toList();

            return SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 🔥 HEADER
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Hello, Welcome 👋",
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 4),
                          Text(name,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite_border, size: 26),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => WishlistScreen()),
                          );
                        },
                      )
                    ],
                  ),

                  SizedBox(height: 20),

                  // 🔥 SALE BANNER
                  Container(
                    height: 120,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(products[3]['image']),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "🔥 Big Sale 50% OFF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // 🔥 CATEGORY BUTTONS
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        categoryBtn("All"),
                        categoryBtn("Men"),
                        categoryBtn("Women"),
                        categoryBtn("Shoes"),
                        categoryBtn("Accessories"),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // 🔥 PRODUCT GRID
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 0.60,
                    ),
                    itemBuilder: (context, index) {

                      final p = filtered[index];

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ProductDetailScreen(product: p),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [

                              // IMAGE + WISHLIST
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                    child: Image.network(
                                      p['image'],
                                      height: 160,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  // Positioned(
                                  //   right: 10,
                                  //   top: 10,
                                  //   child: Container(
                                  //     padding: EdgeInsets.all(6),
                                  //     decoration: BoxDecoration(
                                  //       color: Colors.white,
                                  //       shape: BoxShape.circle,
                                  //     ),
                                  //     child: GestureDetector(
                                  //       onTap: () {
                                  //         setState(() {
                                  //           if (wishlist.contains(p)) {
                                  //             wishlist.remove(p);
                                  //           } else {
                                  //             wishlist.add(p);
                                  //           }
                                  //         });
                                  //       },
                                  //       child: Icon(
                                  //         wishlist.contains(p)
                                  //             ? Icons.favorite
                                  //             : Icons.favorite_border,
                                  //         color: wishlist.contains(p) ? Colors.red : Colors.black,
                                  //         size: 18,
                                  //       ),
                                  //     )
                                  //   ),
                                  // )
                                ],
                              ),

                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      p['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text(
                                      p['shortDescription'] ?? "",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[600],
                                      ),
                                    ),

                                    SizedBox(height: 6),

                                    SizedBox(height: 5),

                                    Row(
                                      children: [
                                        Text(
                                          "₹${p['price']}",
                                          style: TextStyle(
                                              fontWeight:
                                              FontWeight.bold),
                                        ),
                                        SizedBox(width: 10),
                                        Icon(Icons.star,
                                            color: Colors.orange,
                                            size: 16),
                                        Text("5.0")
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget categoryBtn(String title) {
    bool selected = selectedCategory == title;

    return GestureDetector(
      onTap: () {
        setState(() => selectedCategory = title);
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}