import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'screens/signin_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/favorites_screen.dart';
import 'screens/doctor_screen.dart';
import 'screens/food_screen.dart';
import 'screens/grooming_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/main_navigation.dart';
import 'screens/sell_pet_screen.dart';
import 'services/favorites_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoritesService(),
      child: MaterialApp(
        title: 'WeFind App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: const MaterialColor(0xFFFF8C42, {
            50: Color(0xFFFFF3E0),
            100: Color(0xFFFFE0B2),
            200: Color(0xFFFFCC80),
            300: Color(0xFFFFB74D),
            400: Color(0xFFFFA726),
            500: Color(0xFFFF8C42),
            600: Color(0xFFFF7043),
            700: Color(0xFFFF5722),
            800: Color(0xFFF4511E),
            900: Color(0xFFE65100),
          }),
          textTheme: GoogleFonts.interTextTheme(),
          fontFamily: GoogleFonts.inter().fontFamily,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/onboarding',
        routes: {
          '/onboarding': (context) => const OnboardingScreen(),
          '/': (context) => const MainNavigation(),
          '/signin': (context) => const SignInScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/favorites': (context) => const FavoritesScreen(),
          '/doctor': (context) => const DoctorScreen(),
          '/food': (context) => const FoodScreen(),
          '/grooming': (context) => const GroomingScreen(),
          '/sell_pet': (context) => const SellPetScreen(),
        },
      ),
    );
  }
}