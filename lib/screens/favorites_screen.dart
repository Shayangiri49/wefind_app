import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/responsive_helper.dart';
import '../services/favorites_service.dart';
import '../models/dog_model.dart';
import '../utils/app_colors.dart';
import '../screens/dog_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        child: Column(
          children: [
            SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 32)), // Added space above header
            // Header
            _buildHeader(context),
            SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 20)),
            // Favorites content
            Expanded(
              child: Consumer<FavoritesService>(
                builder: (context, favoritesService, child) {
                  if (!favoritesService.hasFavorites) {
                    return _buildEmptyState();
                  }
                  return _buildFavoritesGrid(context, favoritesService);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Search button on the left
          IconButton(
            icon: Icon(Icons.search, color: Colors.black, size: ResponsiveHelper.responsiveIconSize(context, mobile: 24)),
            tooltip: 'Search Favorites',
            onPressed: () {
              // TODO: Implement search functionality
              print('Search button tapped');
            },
          ),
          Text(
            'My Favorites',
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 24),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Consumer<FavoritesService>(
            builder: (context, favoritesService, child) {
              if (!favoritesService.hasFavorites) {
                return const SizedBox(width: 48); // Placeholder for spacing
              }
              return IconButton(
                onPressed: () => _showClearFavoritesDialog(context),
                icon: Icon(Icons.clear_all, color: Colors.red, size: ResponsiveHelper.responsiveIconSize(context, mobile: 24)),
                tooltip: 'Clear all favorites',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 80),
            color: Colors.grey[400],
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 16)),
          Text(
            'No favorites yet',
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 20),
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 8)),
          Text(
            'Start swiping right or tapping hearts\nto add dogs to your favorites!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesGrid(BuildContext context, FavoritesService favoritesService) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: ResponsiveHelper.responsiveColumns(context),
          crossAxisSpacing: ResponsiveHelper.responsiveSpacing(context, mobile: 16),
          mainAxisSpacing: ResponsiveHelper.responsiveSpacing(context, mobile: 16),
          childAspectRatio: 0.75,
        ),
        itemCount: favoritesService.favoriteDogs.length,
        itemBuilder: (context, index) {
          final dog = favoritesService.favoriteDogs[index];
          return _buildFavoriteCard(context, dog, favoritesService);
        },
      ),
    );
  }

  Widget _buildFavoriteCard(BuildContext context, Dog dog, FavoritesService favoritesService) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DogDetailScreen(dog: dog),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 16)),
                      topRight: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 16)),
                    ),
                    child: Image.network(
                      dog.imageUrl,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              Icons.pets,
                              size: ResponsiveHelper.responsiveIconSize(context, mobile: 40),
                              color: Colors.grey,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Favorite button overlay
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => favoritesService.toggleFavorite(dog),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.favorite,
                          color: AppColors.primaryOrange,
                          size: ResponsiveHelper.responsiveIconSize(context, mobile: 20),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Info section
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      dog.name,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: ResponsiveHelper.responsiveSpacing(context, mobile: 2)),
                    Text(
                      dog.breed,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12),
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '\$99',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryOrange,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: ResponsiveHelper.responsiveIconSize(context, mobile: 14),
                              color: AppColors.primaryOrange,
                            ),
                            SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 2)),
                            Text(
                              dog.rating.toString(),
                              style: TextStyle(
                                fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showClearFavoritesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear All Favorites'),
          content: const Text(
            'Are you sure you want to remove all dogs from your favorites? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.read<FavoritesService>().clearFavorites();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Clear All',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
