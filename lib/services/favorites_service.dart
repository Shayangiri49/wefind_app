import 'package:flutter/foundation.dart';
import '../models/dog_model.dart';

class FavoritesService extends ChangeNotifier {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  final Set<String> _favoriteDogIds = <String>{};
  final List<Dog> _favoriteDogs = <Dog>[];

  // Getters
  Set<String> get favoriteDogIds => Set.from(_favoriteDogIds);
  List<Dog> get favoriteDogs => List.from(_favoriteDogs);
  bool get hasFavorites => _favoriteDogs.isNotEmpty;

  // Check if a dog is favorited
  bool isFavorite(String dogId) {
    return _favoriteDogIds.contains(dogId);
  }

  // Add a dog to favorites
  void addToFavorites(Dog dog) {
    if (!_favoriteDogIds.contains(dog.id)) {
      _favoriteDogIds.add(dog.id);
      _favoriteDogs.add(dog);
      notifyListeners();
    }
  }

  // Remove a dog from favorites
  void removeFromFavorites(String dogId) {
    if (_favoriteDogIds.contains(dogId)) {
      _favoriteDogIds.remove(dogId);
      _favoriteDogs.removeWhere((dog) => dog.id == dogId);
      notifyListeners();
    }
  }

  // Toggle favorite status
  void toggleFavorite(Dog dog) {
    if (isFavorite(dog.id)) {
      removeFromFavorites(dog.id);
    } else {
      addToFavorites(dog);
    }
  }

  // Clear all favorites
  void clearFavorites() {
    _favoriteDogIds.clear();
    _favoriteDogs.clear();
    notifyListeners();
  }
}
