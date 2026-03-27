import 'package:flutter/material.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/screens/home_screen.dart';
import 'package:shopping_app/screens/signup_screen.dart';

import '../services/api_services.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7),

      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text("Welcome Back",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),

            SizedBox(height: 30),

            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: password,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
            ),

            SizedBox(height: 25),

            GestureDetector(
              onTap: () async {
                await AuthService.login(
                  email.text,
                  password.text,
                );

               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
              },
              child: Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text("Login",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
SizedBox(height: 30,),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have any Account ?",style: TextStyle(color: Colors.black),),
                SizedBox(width: 10,),
                GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                    },
                    child: Text("Create Account",style: TextStyle(color: Colors.blue),)),

              ],
            )
          ],
        ),
      ),
    );
  }
}