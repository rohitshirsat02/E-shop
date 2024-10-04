import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  // const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulate a delay for the splash screen before navigating
    Future.delayed(const Duration(seconds: 2), () {
      bool isAuthenticated = false; // Set to true if the user is authenticated
      if (isAuthenticated) {
        Get.off(() => HomeScreen());
      } else {
        Get.off(() => LoginScreen());
      }
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Splash screen background colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart, // Shopping symbol
                size: 100.0,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to E-Shop',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
