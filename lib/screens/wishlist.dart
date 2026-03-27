import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_app/screens/productDetail_screen.dart';
import '../services/api_services.dart';

class WishlistScreen extends StatefulWidget {
  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  List wishlist = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWishlist();
  }
  Future<void> loadWishlist() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userId = prefs.getString("userId") ?? "";

      final data = await ApiService.getWishlist(userId);

      setState(() {
        wishlist = data;
        isLoading = false;
      });

    } catch (e) {
      print("ERROR: $e");

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),

      appBar: AppBar(
        title: Text("Wishlist", style: TextStyle(color: Colors.black)),
        backgroundColor: Color(0xFFF7F7F7),
        elevation: 0,
        centerTitle: true,
      ),

      body: isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFFFF6F61),))
          : wishlist.isEmpty
          ? Center(child: Text("No items in wishlist"))
          : RefreshIndicator(
        onRefresh: loadWishlist,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            itemCount: wishlist.length,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 0.60,
            ),
            itemBuilder: (_, i) {

              final p = wishlist[i]['product'];

              return GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailScreen(product: p)));
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // 🔥 IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: Image.network(
                          p['image'],
                          height: 160,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Image.network(
                              "https://picsum.photos/500/700",
                              height: 160,
                              fit: BoxFit.cover,
                            );
                          },
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
                                  fontWeight: FontWeight.bold),
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

                            Text(
                              "₹${p['price']}",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}