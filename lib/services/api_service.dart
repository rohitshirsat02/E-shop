import 'package:ecommerce_app/models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'https://fakestoreapi.com/products';
  final String categoryUrl = 'https://fakestoreapi.com/products/categories'; // Category endpoint

  // Fetch products from the Fake Store API
  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load products");
    }
  }

  // Fetch categories from the API
  Future<List<String>> fetchCategories() async {
    final response = await http.get(Uri.parse(categoryUrl));

    if (response.statusCode == 200) {
      List<dynamic> categories = jsonDecode(response.body);
      return List<String>.from(categories); // Convert dynamic to List<String>
    } else {
      throw Exception("Failed to load categories");
    }
  }
}
