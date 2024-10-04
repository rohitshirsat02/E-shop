import 'package:ecommerce_app/models/cart_model.dart'; // Make sure the correct import path is used
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../controllers/cart_controller.dart';
// Correct path to your CartItem model


class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  final CartController cartController = Get.put(CartController());

  ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.image, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              product.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              "\$${product.price}",
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              product.description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Add to Cart functionality
                    cartController.addToCart(
                      CartItem(
                        id: product.id.toString(),
                        title: product.title,
                        image: product.image, // Ensure image is passed here
                        price: product.price,
                        quantity: 1,
                      ),
                    );
                    Get.snackbar('Success', 'Product added to cart');
                  },
                  child: const Text("Add to Cart"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Buy Now functionality - navigate to CartScreen
                    Get.toNamed('/cart'); // Assuming you have CartScreen routed
                  },
                  child: const Text("Buy Now"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
