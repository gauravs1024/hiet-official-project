import 'package:flutter/material.dart';
import 'package:hiet_official_project/Pages/HomePage.dart';
import 'package:hiet_official_project/Pages/LoginPage.dart';
import 'package:hiet_official_project/SharedPreferences/SharedPreferencesSession.dart';

bool loggedInFlag=false;
Future<void> main() async {
  // HttpOverrides.global = MyHttpOverrides(); // Bypass SSL

  WidgetsFlutterBinding.ensureInitialized();


    Map<String,String?> sessionData;
  UserSharedPreferences userSharedPreferences=UserSharedPreferences();
  sessionData=await userSharedPreferences.loadUserData();
  print('session $sessionData');

  if(sessionData['isLoggedIn']!=null){
    loggedInFlag=true;
  }
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
      home:loggedInFlag?HomePage():LoginPage(),
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
