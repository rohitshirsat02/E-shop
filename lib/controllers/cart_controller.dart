import 'package:get/get.dart';
import '../models/cart_model.dart'; // Correct import path

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs; // List of items in the cart

  // Add item to the cart
  void addToCart(CartItem item) {
    // Check if item already exists in cart
    final existingItem = cartItems.firstWhereOrNull((cartItem) => cartItem.id == item.id);
    if (existingItem != null) {
      existingItem.quantity++;
      cartItems.refresh(); // Refresh the list
    } else {
      cartItems.add(item); // Add new item to cart
    }
  }

  // Remove item from the cart
  void removeFromCart(String id) {
    cartItems.removeWhere((item) => item.id == id);
  }

  // Update item quantity
  void updateQuantity(String id, int quantity) {
    final item = cartItems.firstWhereOrNull((cartItem) => cartItem.id == id);
    if (item != null && quantity > 0) {
      item.quantity = quantity;
      cartItems.refresh(); // Refresh the list
    } else {
      removeFromCart(id); // Remove item if quantity is 0 or less
    }
  }

  // Calculate subtotal
  double get subtotal {
    return cartItems.fold(0, (total, item) => total + item.totalPrice);
  }

  // Placeholder for discounts and taxes (you can modify this based on your requirements)
  double get discount => 0; // Placeholder discount
  double get tax => subtotal * 0.1; // Example tax of 10%
  double get total => subtotal - discount + tax; // Total calculation
}
