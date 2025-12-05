import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ukl2025/views/home_page.dart';
import 'package:ukl2025/views/splash_screen.dart';
import 'package:ukl2025/views/login_page.dart';
import 'package:ukl2025/views/main_screen.dart'; // Asumsi ini adalah Home utama

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.literataTextTheme(Theme.of(context).textTheme),
        scaffoldBackgroundColor: Colors.deepOrange,
      ),

      initialRoute: '/',
      routes: {
        '/': (context) =>
            const SplashScreen(), // Rute '/' mengarah ke SplashScreen
        '/login': (context) =>
            const LoginPage(), // Rute '/login' mengarah ke LoginPage
        '/main': (context) =>
            HomePage(), // Rute '/main' mengarah ke MainScreen (setelah Login)
      },
    );
  }
}
