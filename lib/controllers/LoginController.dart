import 'package:ecommerce_app/screens/home_screen.dart';
import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  var isLogin = true.obs; // Observable for login/signup toggle
  var isAuthenticated = false.obs; // Observable to check if the user is authenticated
  var isSignedUp = false.obs; // Observable to check if the user has signed up successfully

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController(); // For the signup confirm password

  void toggleForm() {
    isLogin.value = !isLogin.value; // Toggle between login and signup
  }

  // Login logic
  void login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      // Simulate a successful login (you can add your API logic here)
      isAuthenticated.value = true;
      print("Logged in with: ${emailController.text}");

      // If login successful, navigate to HomeScreen
      if (isAuthenticated.value) {
        Get.off(() => HomeScreen());
      }
    } else {
      Get.snackbar("Error", "Please enter valid login credentials");
    }
  }

  // Sign-up logic
  void signUp() {
    // Add validation for signup
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {

      if (passwordController.text == confirmPasswordController.text) {
        // Simulate a successful signup (you can add your API logic here)
        isSignedUp.value = true;
        print("Signed up with: ${emailController.text}");

        // If signup successful, navigate back to LoginScreen for login
        if (isSignedUp.value) {
          Get.off(() => LoginScreen());
        }
      } else {
        Get.snackbar("Error", "Passwords do not match");
      }
    } else {
      Get.snackbar("Error", "All fields are required");
    }
  }

  // Guest login logic
  void guestLogin() {
    // Simulate a guest login (you can add your API logic here)
    isAuthenticated.value = true;
    print("Logged in as Guest");

    // Navigate to HomeScreen if guest login is successful
    if (isAuthenticated.value) {
      Get.off(() => HomeScreen());
    }
  }

  // Navigate to Forgot Password screen
  void navigateToForgotPassword() {
    // You can add the navigation logic to Forgot Password screen
    print("Navigating to forgot password");
    Get.snackbar("Forgot Password", "Forgot password feature is not implemented yet");
  }

  // Cleanup: dispose controllers when not needed
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
