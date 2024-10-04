import 'package:get/get.dart';
import '../screens/home_screen.dart'; // Import your Home Screen
import '../screens/login_screen.dart'; // Import your Login Screen

class AuthController extends GetxController {
  // This is the method to simulate the data fetching and checking authentication
  @override
  void onReady() {
    super.onReady();
    _checkAuthStatus();
  }

  void _checkAuthStatus() async {
    // Simulate fetching initial data like product categories, user info, etc.
    await Future.delayed(const Duration(seconds: 3)); // Mock delay for data fetching

    // Simulate authentication check logic (Replace with real auth logic)
    bool isAuthenticated = false; // You can replace this with real authentication status

    if (isAuthenticated) {
      // If user is authenticated, navigate to the home screen
      Get.offAll(() => HomeScreen()); // Navigating to Home without back stack
    } else {
      // If user is not authenticated, navigate to the login screen
      Get.offAll(() => LoginScreen()); // Navigating to Login without back stack
    }
  }
}
