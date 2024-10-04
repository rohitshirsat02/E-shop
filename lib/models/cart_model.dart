class CartItem {
  String id;
  String title;
  String image;
  double price;
  int quantity;

  CartItem({
    required this.id,
    required this.title,
    required this.image, // Ensure image is required
    required this.price,
    this.quantity = 1,
  });

  // Calculate total price based on quantity
  double get totalPrice => price * quantity;
}
