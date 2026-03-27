import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const baseUrl = "http://10.36.222.247:5000";

  static Future<List> getProducts() async {
    final res = await http.get(Uri.parse("$baseUrl/products"));
    return jsonDecode(res.body);
  }
  static Future toggleWishlist(String userId, Map product) async {
    await http.post(
      Uri.parse("$baseUrl/api/wishlist"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "userId": userId,
        "product": product,
      }),
    );
  }
  static Future getWishlist(String userId) async {
    final res = await http.get(
      Uri.parse("$baseUrl/api/wishlist/$userId"),
    );

    print("URL: $baseUrl/api/wishlist/$userId");
    print("RESPONSE: ${res.body}");

    return jsonDecode(res.body);
  }
  static Future signup(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(res.body);
  }

  static Future login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/auth/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    return jsonDecode(res.body);
  }
}

class AuthService {

  static String baseUrl = "http://10.36.222.247:5000/api/auth";

  static Future signup(String name, String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/signup"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": name,
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(res.body);

    print("SIGNUP RESPONSE: $data"); // 🔥 debug

    if (data['token'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString("token", data['token']);
      prefs.setString("userId", data['userId']); // ✅ VERY IMPORTANT
      prefs.setString("name", data['name']);
      prefs.setString("email", data['email']);
    }

    return data;
  }
  static Future login(String email, String password) async {
    final res = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "password": password,
      }),
    );

    final data = jsonDecode(res.body);

    if (data['token'] != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", data['token']);
    }

    return data;
  }
}