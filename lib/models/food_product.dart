class FoodProduct {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final int reviews;
  final double weight;

  FoodProduct({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    this.rating = 4.5,
    this.reviews = 0,
    this.weight = 1.0,
  });

  factory FoodProduct.fromJson(Map<String, dynamic> json) {
    return FoodProduct(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      imageUrl: json['image'] ?? json['imageUrl'] ?? '',
      description: json['description'] ?? '',
      rating: (json['rating'] ?? 4.5).toDouble(),
      reviews: json['reviews'] ?? 0,
      weight: (json['weight'] ?? 1.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imageUrl': imageUrl,
      'description': description,
      'rating': rating,
      'reviews': reviews,
      'weight': weight,
    };
  }
}
