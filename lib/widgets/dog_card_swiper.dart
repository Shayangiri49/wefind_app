import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:provider/provider.dart';
import '../utils/responsive_helper.dart';
import '../models/dog_model.dart';
import '../services/favorites_service.dart';
import '../widgets/action_buttons.dart';
import '../screens/dog_detail_screen.dart';

class DogCardSwiper extends StatefulWidget {
  final List<Dog> dogs;
  final CardSwiperController? controller;
  final bool Function(int previousIndex, int? currentIndex, CardSwiperDirection direction)? onSwipe;
  final VoidCallback? onCross;
  final VoidCallback? onHeart;
  final VoidCallback? onStar;
  final Function(int)? onIndexChanged;
  const DogCardSwiper({
    Key? key,
    required this.dogs,
    this.controller,
    this.onSwipe,
    this.onCross,
    this.onHeart,
    this.onStar,
    this.onIndexChanged,
  }) : super(key: key);

  @override
  State<DogCardSwiper> createState() => _DogCardSwiperState();
}

class _DogCardSwiperState extends State<DogCardSwiper> with TickerProviderStateMixin {
  int _currentIndex = 0;

  void _openProductDetail(Dog dog) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DogDetailScreen(dog: dog),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ResponsiveHelper.responsiveCardWidth(context),
        height: ResponsiveHelper.responsiveCardHeight(context) + 48, // Add space for buttons
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned.fill(
              child: CardSwiper(
                controller: widget.controller,
                cardsCount: widget.dogs.length,
                allowedSwipeDirection: const AllowedSwipeDirection.only(left: true, right: true),
                cardBuilder: (context, i, percentX, percentY) => GestureDetector(
                  onTap: () => _openProductDetail(widget.dogs[i]),
                  child: DogCard(dog: widget.dogs[i]),
                ),
                numberOfCardsDisplayed: 3,
                isLoop: false,
                onSwipe: (previousIndex, currentIndex, direction) {
                  setState(() {
                    _currentIndex = currentIndex ?? 0;
                  });
                  
                  // Notify parent of index change
                  widget.onIndexChanged?.call(_currentIndex);
                  
                  // Handle favorites when swiping right
                  if (direction == CardSwiperDirection.right) {
                    final dog = widget.dogs[previousIndex];
                    context.read<FavoritesService>().addToFavorites(dog);
                  }
                  
                  return widget.onSwipe?.call(previousIndex, currentIndex, direction) ?? true;
                },
              ),
            ),
            // Action buttons overlay, half-in/half-out of the card
            Positioned(
              bottom: -28,
              left: 0,
              right: 0,
              child: ActionButtons(
                onCross: widget.onCross ?? () {},
                onHeart: widget.onHeart ?? () {},
                onStar: () {
                  // Open product detail for the top dog
                  if (widget.dogs.isNotEmpty) {
                    final dog = widget.dogs[_currentIndex.clamp(0, widget.dogs.length - 1)];
                    _openProductDetail(dog);
                  }
                  if (widget.onStar != null) widget.onStar!();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DogCard extends StatelessWidget {
  final Dog dog;
  const DogCard({Key? key, required this.dog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 28)),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              dog.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      Icons.pets,
                      size: ResponsiveHelper.responsiveIconSize(context, mobile: 64),
                      color: Colors.grey,
                    ),
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFA726)),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 110,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Color(0xFFFFA726),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 32,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dog.name,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 28),
                  ),
                ),
                SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 4)),
                Text(
                  dog.breed,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
