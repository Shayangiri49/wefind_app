import 'package:flutter/material.dart';
import 'package:wefind_app/utils/responsive_helper.dart';
import '../utils/app_colors.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: ResponsiveHelper.screenHeight(context) - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.screenWidth(context) * 0.1), // 10% margin from edges
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 60), // Top spacing
                  
                  // Logo Section
                  _buildLogo(),
                  
                  const SizedBox(height: 60), // Space after logo
                  
                  // Sign in Title
                  Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 28),
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText,
                    ),
                  ),
                  
                  const SizedBox(height: 32), // Space after title
                  
                  // Google Button (Full width)
                  _buildGoogleButton(),
                  
                  const SizedBox(height: 16), // Space between Google and social buttons
                  
                  // Facebook and Twitter Buttons Row (Side by side)
                  _buildSocialButtonsRow(),
                  
                  const SizedBox(height: 24), // Space before "Or with Email"
                  
                  // Or with Email text
                  Text(
                    'Or with Email',
                    style: TextStyle(
                      fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14),
                      color: AppColors.subtleGray,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  
                  const SizedBox(height: 20), // Space after "Or with Email"
                  
                  // Email Field
                  _buildEmailField(),
                  
                  const SizedBox(height: 12), // Space between input fields
                  
                  // Password Field
                  _buildPasswordField(),
                  
                  const SizedBox(height: 24), // Space before Sign In button
                  
                  // Sign In Button
                  _buildSignInButton(),
                  
                  const SizedBox(height: 64), // More space before sign up link (increased)
                  
                  // Sign Up Link
                  _buildSignUpLink(),
                  
                  const SizedBox(height: 40), // Bottom spacing
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Paw Icon
        Container(
          width: ResponsiveHelper.responsiveValue(context, mobile: 52), // Increased size
          height: ResponsiveHelper.responsiveValue(context, mobile: 52), // Increased size
          decoration: const BoxDecoration(
            gradient: AppColors.orangeGradient,
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.pets,
            color: Colors.white,
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 32), // Increased icon size
          ),
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 14)), // Slightly more spacing between icon and text
        // wefind Text
        Text(
          'wefind',
          style: TextStyle(
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 40), // Increased font size
            fontWeight: FontWeight.w700,
            color: AppColors.darkText,
            letterSpacing: -0.3,
          ),
        ),
        // Trademark symbol
        Container(
          margin: const EdgeInsets.only(left: 2, bottom: 18), // Lowered to match bigger text
          child: Text(
            '™',
            style: TextStyle(
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 14), // Increased font size
              color: AppColors.darkText,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.orangeGradient,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryOrange.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
            onTap: () {
  Navigator.pushReplacementNamed(context, "/");
},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'G',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12),
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryOrange,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'With Google',
                  style: TextStyle(
                    fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButtonsRow() {
    return Row(
      children: [
        // Facebook Button
        Expanded(
          child: _buildSocialButton(
            'f',
            AppColors.facebookBlue,
          ),
        ),
        const SizedBox(width: 12), // Space between buttons
        // Twitter Button  
        Expanded(
          child: _buildSocialButton(
            '𝕏',
            AppColors.twitterBlue,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialButton(String icon, Color iconColor) {
    return SizedBox(
      height: 48,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
          border: Border.all(
            color: const Color(0xFFE0E0E0),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
          child: InkWell(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
            onTap: () {},
            child: Center(
              child: Text(
                icon,
                style: TextStyle(
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 16),
                  fontWeight: FontWeight.w600,
                  color: iconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
          color: AppColors.darkText,
        ),
        decoration: InputDecoration(
          hintText: 'Your Email',
          hintStyle: TextStyle(
            color: AppColors.subtleGray,
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
            fontWeight: FontWeight.w400,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
            borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
            borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
            borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
          ),
          suffixIcon: Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.subtleGray,
            size: ResponsiveHelper.responsiveIconSize(context, mobile: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: _passwordController,
        obscureText: true,
        style: TextStyle(
          fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
          color: AppColors.darkText,
        ),
        decoration: InputDecoration(
          hintText: '••••••••',
          hintStyle: TextStyle(
            color: AppColors.subtleGray,
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
            letterSpacing: 1.5,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
            borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
            borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 8)),
            borderSide: const BorderSide(color: AppColors.primaryOrange, width: 1.5),
          ),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              widthFactor: 1,
              child: Text(
                'Forgot?',
                style: TextStyle(
                  color: AppColors.subtleGray,
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 12),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColors.orangeGradient,
          borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryOrange.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 24)),
            onTap: () {
  Navigator.pushReplacementNamed(context, "/");
},
            child: Center(
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 15),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'New User? ',
          style: TextStyle(
            color: AppColors.subtleGray,
            fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 13),
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigate to sign up
          },
          child: Text(
            'Sign Up',
            style: TextStyle(
              color: AppColors.primaryOrange,
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 13),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}