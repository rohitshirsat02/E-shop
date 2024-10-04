import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';


class CartScreen extends StatelessWidget {
  final CartController cartController = Get.put(CartController());

  // const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        if (cartController.cartItems.isEmpty) {
          return const Center(child: Text('Your cart is empty.'));
        }

        return ListView.builder(
          itemCount: cartController.cartItems.length,
          itemBuilder: (context, index) {
            final item = cartController.cartItems[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(item.title),
                subtitle: Text("Price: \$${item.price} x ${item.quantity}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => cartController.removeFromCart(item.id),
                ),
                onTap: () => _showQuantityDialog(context, item),
              ),
            );
          },
        );
      }),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  // Function to show dialog for updating quantity
  void _showQuantityDialog(BuildContext context, CartItem item) {
    int quantity = item.quantity;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Quantity'),
          content: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (quantity > 1) {
                    quantity--;
                    Get.back();
                    _showQuantityDialog(context, item); // Show dialog again
                  }
                },
              ),
              Text(quantity.toString()),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  quantity++;
                  Get.back();
                  _showQuantityDialog(context, item); // Show dialog again
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Save'),
              onPressed: () {
                cartController.updateQuantity(item.id, quantity);
                Get.back(); // Close dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Bottom navigation bar showing subtotal and proceed to checkout button
  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.shopping_cart),
          label: 'Subtotal: \$${Get.find<CartController>().subtotal.toStringAsFixed(2)}',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Checkout',
        ),
      ],
      onTap: (index) {
        if (index == 1) {
          // Navigate to checkout process
          Get.snackbar("Checkout", "Proceeding to checkout...");
        }
      },
    );
  }
}
