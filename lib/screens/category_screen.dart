import 'package:ecommerce_app/models/product_model.dart';
import 'package:flutter/material.dart';
import '../services/api_service.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  CategoryScreen({super.key, required this.category});


  final ApiService apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: FutureBuilder<List<ProductModel>>(
        future: apiService.fetchProducts(), // Fetch all products
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No products found."));
          }

          // Filter products based on the selected category
          List<ProductModel> filteredProducts = snapshot.data!.where((product) {
            return product.category.toLowerCase() == category.toLowerCase(); // Adjust this logic if needed
          }).toList();

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final product = filteredProducts[index];
              return GestureDetector(
                onTap: () {
                  // Navigate to the product details screen when tapped
                  // Get.to(() => ProductDetailsScreen(product: product));
                },
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(product.image, fit: BoxFit.cover),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text("\$${product.price}"),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
