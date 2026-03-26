import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "http://10.36.222.247:5000";

  static Future<List> getProducts() async {
    final res = await http.get(Uri.parse("$baseUrl/products"));
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