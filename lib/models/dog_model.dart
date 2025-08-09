class Dog {
  final String id;
  final String name;
  final String breed;
  final String imageUrl;
  final int age;
  final List<String> tags;
  final double price;
  final double rating;
  final List<String> availableSizes;
  final String description;

  Dog({
    required this.id,
    required this.name,
    required this.breed,
    required this.imageUrl,
    required this.age,
    required this.tags,
    this.price = 99.99,
    this.rating = 4.5,
    this.availableSizes = const ['S', 'M', 'L', 'XL'],
    this.description = 'A lovely dog looking for a new home. Friendly, playful, and loyal.',
  });

  static List<Dog> getSampleDogs() {
    return [
      Dog(
        id: '1',
        name: 'Dubby',
        breed: 'Golden Retriever',
        imageUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=500&h=600&fit=crop',
        age: 2,
        tags: ['Playful', 'Friendly'],
        price: 120.00,
        rating: 4.7,
        availableSizes: ['S', 'M', 'L', 'XL'],
        description: 'Dubby is a playful Golden Retriever who loves to fetch and cuddle.',
      ),
      Dog(
        id: '2',
        name: 'Luna',
        breed: 'German Shepherd',
        imageUrl: 'https://images.unsplash.com/photo-1589941013453-ec89f33b5e95?w=500&h=600&fit=crop',
        age: 3,
        tags: ['Loyal', 'Smart'],
        price: 150.00,
        rating: 4.8,
        availableSizes: ['M', 'L', 'XL'],
        description: 'Luna is a smart and loyal German Shepherd, perfect for families.',
      ),
      Dog(
        id: '3',
        name: 'Max',
        breed: 'Border Collie',
        imageUrl: 'https://images.unsplash.com/photo-1551717743-49959800b1f6?w=500&h=600&fit=crop',
        age: 4,
        tags: ['Active', 'Intelligent'],
        price: 110.00,
        rating: 4.6,
        availableSizes: ['S', 'M', 'XL'],
        description: 'Max is an active Border Collie who loves to run and play.',
      ),
      Dog(
        id: '4',
        name: 'Bella',
        breed: 'Labrador',
        imageUrl: 'https://images.unsplash.com/photo-1518717758536-85ae29035b6d?w=500&h=600&fit=crop',
        age: 1,
        tags: ['Gentle', 'Loving'],
        price: 130.00,
        rating: 4.9,
        availableSizes: ['M', 'L', 'XL'],
        description: 'Bella is a gentle Labrador who loves kids and other pets.',
      ),
      Dog(
        id: '5',
        name: 'Charlie',
        breed: 'Beagle',
        imageUrl: 'https://images.unsplash.com/photo-1560807707-8cc77767d783?w=500&h=600&fit=crop',
        age: 5,
        tags: ['Curious', 'Friendly'],
        price: 90.00,
        rating: 4.3,
        availableSizes: ['S', 'M', 'L', 'XL'],
        description: 'Charlie is a curious Beagle who loves to explore.',
      ),
      Dog(
        id: '6',
        name: 'Buddy',
        breed: 'Golden Retriever',
        imageUrl: 'https://images.unsplash.com/photo-1552053831-71594a27632d?w=500&h=600&fit=crop',
        age: 2,
        tags: ['Playful', 'Friendly'],
        price: 125.00,
        rating: 4.7,
        availableSizes: ['M', 'L', 'XL'],
        description: 'Buddy is a friendly Golden Retriever who loves everyone.',
      ),
      Dog(
        id: '7',
        name: 'Daisy',
        breed: 'Poodle',
        imageUrl: 'https://images.unsplash.com/photo-1560807707-8cc77767d783?w=500&h=600&fit=crop',
        age: 3,
        tags: ['Elegant', 'Smart'],
        price: 140.00,
        rating: 4.8,
        availableSizes: ['S', 'M', 'XL'],
        description: 'Daisy is an elegant Poodle with a smart personality.',
      ),
    ];
  }
}
