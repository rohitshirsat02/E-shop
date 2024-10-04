import 'package:ecommerce_app/screens/login_screen.dart';
import 'package:ecommerce_app/screens/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../controllers/HomeController.dart';
import '../models/product_model.dart';
import '../screens/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(() => LoginScreen()); // Navigate back to the login screen
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Get.snackbar("Search", "Search functionality not implemented");
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartScreen()); // Navigate to CartScreen
            },
          ),
        ],
      ),
      body: Obx(() {
        if (homeController.isLoading.value) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading spinner
        }

        if (homeController.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Failed to load data.'),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    homeController.fetchProducts(); // Retry fetching data
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBannerCarousel(homeController.banners),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall, // Theme applied here
                ),
              ),
              _buildCategoryGrid(context, homeController.productCategories),
              // Pass context here
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Featured Products',
                  style: Theme
                      .of(context)
                      .textTheme
                      .headlineSmall, // Theme applied here
                ),
              ),
              _buildProductGrid(homeController.featuredProducts),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildBannerCarousel(List<String> banners) {
    return CarouselSlider(
      options: CarouselOptions(autoPlay: true),
      items: banners.map((banner) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Image.asset(banner, fit: BoxFit.cover),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryGrid(BuildContext context, List<String> categories) {
    return categories.isNotEmpty
        ? GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => homeController.goToCategory(categories[index]),
          child: Card(
            child: Center(
              child: Text(
                categories[index],
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyMedium, // Apply theme here
              ),
            ),
          ),
        );
      },
    )
        : Center(
      child: Text(
        "No categories available",
        style: Theme
            .of(context)
            .textTheme
            .bodyMedium, // Apply theme here
      ),
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6, // Adjust the aspect ratio to fit the image properly
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {

            // Navigate to product details if needed
            Get.to(() => ProductDetailsScreen(product: product));
          },
          child: Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Constrain the height of the image to avoid overflow
                SizedBox(
                  height: 150, // Adjust this height as necessary
                  child: Image.network(
                    product.image,
                    fit: BoxFit.cover, // Scale image to fit the container
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons
                          .error); // Show error icon if the image fails to load
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium, // Apply theme here
                  ),
                ),
                Text("\$${product.price}"),
              ],
            ),
          ),
        );
      },
    );
  }
}