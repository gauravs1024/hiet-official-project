import 'package:flutter/material.dart';
import 'package:hiet_official_project/Pages/HomePage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hiet_official_project/Pages/LoginPage.dart';
import 'package:http/http.dart' as http;

void main() {
  // HttpOverrides.global = MyHttpOverrides(); // Bypass SSL
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      home:LoginPage(),
    );
  }
}


// // Bypass SSL Certificate Validation
// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=>true;}
// }
