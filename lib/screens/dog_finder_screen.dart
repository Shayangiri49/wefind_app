import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import '../utils/responsive_helper.dart';
import '../widgets/header.dart';
import '../widgets/profile_filter.dart';
import '../widgets/dog_card_swiper.dart';
import '../mock/pet_mock_data.dart';
import '../services/favorites_service.dart';
import '../models/dog_model.dart';

class DogFinderScreen extends StatefulWidget {
  const DogFinderScreen({Key? key}) : super(key: key);

  @override
  State<DogFinderScreen> createState() => _DogFinderScreenState();
}

class _DogFinderScreenState extends State<DogFinderScreen> {
  final CardSwiperController _swiperController = CardSwiperController();
  int _currentIndex = 0;
  List<Dog> _filteredDogs = List.from(petMockData);

  void _applyFilters(Map<String, dynamic> filters) {
    setState(() {
      _filteredDogs = petMockData.where((dog) {
        final breedMatch = filters['breed'] == null || dog.breed == filters['breed'];
        final tagMatch = filters['tag'] == null || dog.tags.contains(filters['tag']);
        final ageMatch = filters['age'] == null || dog.age == filters['age'];
        return breedMatch && tagMatch && ageMatch;
      }).toList();
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE0B2),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFEEDC), // soft peach top
              Color(0xFFFFF8EC), // creamy middle
              Color(0xFFFFFFFF), // white at bottom
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveHelper.responsiveValue(context, mobile: 20.0),
              vertical: ResponsiveHelper.responsiveValue(context, mobile: 12.0),
            ),
            child: Column(
              children: [
                // Header with profile and location
                const Header(),
                SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 20)),
                // Filter and pet categories
                ProfileFilter(
                  onFilterChanged: _applyFilters,
                ),
                SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 24)),
                // Card deck and action buttons stacked for overlap
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    clipBehavior: Clip.none,
                    children: [
                      // Swipeable card deck
                      DogCardSwiper(
                        dogs: _filteredDogs,
                        controller: _swiperController,
                        onIndexChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                        // Pass the action button callbacks down
                        onCross: () {
                          _swiperController.swipe(CardSwiperDirection.left);
                          print('Cross button tapped - Swipe left');
                        },
                        onHeart: () {
                          _swiperController.swipe(CardSwiperDirection.right);
                          print('Heart button tapped - Swipe right');
                          // Add current dog to favorites
                          if (petMockData.isNotEmpty && _currentIndex < petMockData.length) {
                            final dog = petMockData[_currentIndex];
                            context.read<FavoritesService>().addToFavorites(dog);
                          }
                        },
                        onStar: () {
                          print('Star button tapped - Star action');
                          // TODO: Implement star action
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 48)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
