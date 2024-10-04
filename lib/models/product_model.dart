class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category; // Add category field
  final String image;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category, // Add category parameter
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      price: json['price'].toDouble(),
      category: json['category'], // Parse category from JSON
      image: json['image'],
    );
  }
}
