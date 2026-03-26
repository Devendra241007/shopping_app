import 'package:flutter/material.dart';
import '../services/api_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void loginUser() async {
    final res = await ApiService.login(email.text, password.text);

    if (res['email'] != null) {
      Navigator.pushReplacementNamed(context, "/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: password, decoration: InputDecoration(labelText: "Password")),

            ElevatedButton(
              onPressed: loginUser,
              child: Text("Login"),
            )
          ],
        ),
      ),
    );
  }
}