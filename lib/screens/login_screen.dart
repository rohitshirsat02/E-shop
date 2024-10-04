import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/LoginController.dart';

class LoginScreen extends StatelessWidget {
  final LoginController loginController = Get.put(LoginController());

  // const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Login/Sign Up')

      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.purple], // Matching splash screen colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(  // This avoids rendering overflow issues
            child: Obx(() => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: loginController.emailController,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),  // Text color updated
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),  // Text input color
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: loginController.passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (loginController.isLogin.value) {
                      loginController.login();
                      if (loginController.isAuthenticated.value) {
                        Get.off(() =>  HomeScreen());
                      }
                    } else {
                      loginController.signUp();
                      if (loginController.isSignedUp.value) {
                        Get.off(() =>  LoginScreen());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue, backgroundColor: Colors.white, // Text color
                  ),
                  child: Text(loginController.isLogin.value ? "Login" : "Sign Up"),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () => loginController.navigateToForgotPassword(),
                  child: const Text("Forgot Password?", style: TextStyle(color: Colors.white)),
                ),
                TextButton(
                  onPressed: () => loginController.toggleForm(),
                  child: Text(
                    loginController.isLogin.value
                        ? "Don't have an account? Sign Up"
                        : "Already have an account? Login",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      onPressed: () => Get.snackbar("Facebook", "Login with Facebook"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.g_translate, color: Colors.red),
                      onPressed: () => Get.snackbar("Google", "Login with Google"),
                    ),
                    IconButton(
                      icon: const Icon(Icons.apple, color: Colors.black),
                      onPressed: () => Get.snackbar("Apple", "Login with Apple"),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => loginController.guestLogin(),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue, backgroundColor: Colors.white,
                  ),
                  child: const Text("Continue as Guest"),
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
