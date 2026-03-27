import 'package:flutter/material.dart';
import '../services/api_services.dart';
import 'productDetail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String query = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),

      appBar: AppBar(
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 0,
        title: Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: TextField(
            onChanged: (val) {
              setState(() => query = val);
            },
            decoration: InputDecoration(
              hintText: "Search clothes...",
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ),
      ),

      body: FutureBuilder(
        future: ApiService.getProducts(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator(color: Color(0xFFFF6F61),));
          }

          List products = snapshot.data!;

          // 🔥 FILTER
          List filtered = products.where((p) =>
              p['name'].toLowerCase().contains(query.toLowerCase())
          ).toList();

          if (filtered.isEmpty) {
            return Center(
              child: Text(
                "No results found",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(16),
            child: GridView.builder(
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        // IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20)),
                          child: Image.network(
                            p['image'],
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
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
                                ),
                              ),

                              SizedBox(height: 4),

                              Text(
                                p['shortDescription'] ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),

                              SizedBox(height: 6),

                              Row(
                                children: [
                                  Text(
                                    "₹${p['price']}",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.star,
                                      size: 14,
                                      color: Colors.orange),
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
            ),
          );
        },
      ),
    );
  }
}