import 'package:get/get.dart';
import '../models/product_model.dart';
import '../screens/category_screen.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  var featuredProducts = <ProductModel>[].obs; // Observable list of featured products
  var productCategories = <String>[].obs; // Observable list of categories
  var banners = <String>["assets/images/banner1.jpeg", "assets/images/banner2.jpg"].obs; // Corrected paths
  // Placeholder banners
  var isLoading = true.obs;  // Observable for loading state
  var hasError = false.obs;  // Observable for error state

  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    fetchProducts();
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchProducts() async {
    try {
      isLoading(true);  // Start loading
      List<ProductModel> products = await _apiService.fetchProducts();
      if (products.isNotEmpty) {
        featuredProducts.assignAll(products);  // Assign fetched products to the observable list
        hasError(false);  // Reset error flag
      } else {
        hasError(true);  // Set error if no products
      }
    } catch (e) {
      print('Error fetching products: $e');
      hasError(true);  // Set error flag
    } finally {
      isLoading(false);  // Stop loading
    }
  }

  Future<void> fetchCategories() async {
    try {
      List<String> categories = await _apiService.fetchCategories();
      productCategories.assignAll(categories);  // Assign fetched categories to the observable list
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  void goToCategory(String category) {
    Get.to(() => CategoryScreen(category: category));  // Pass the category
  }

}
