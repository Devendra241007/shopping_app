import 'package:flutter/material.dart';
import '../services/api_services.dart';

class SignupScreen extends StatefulWidget {
  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  void signupUser() async {
    await ApiService.signup(name.text, email.text, password.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: name, decoration: InputDecoration(labelText: "Name")),
            TextField(controller: email, decoration: InputDecoration(labelText: "Email")),
            TextField(controller: password, decoration: InputDecoration(labelText: "Password")),

            ElevatedButton(
              onPressed: signupUser,
              child: Text("Sign Up"),
            )
          ],
        ),
      ),
    );
  }
}