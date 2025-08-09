import 'package:flutter/material.dart';
import 'package:wefind_app/utils/responsive_helper.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;

  // Theme colors - matching original design
  static const Color _backgroundColor = Color(0xFFF8F6F0);
  static const Color _textColor = Color(0xFF333333);
  static const Color _primaryColor = Color(0xFFF97316); // Orange color
  static const Color _circleColor = Color(0xFFE5E7EB);

  @override
  void initState() {
    super.initState();
    
    // Initialize rotation animation
    _rotationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    
    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));
    
    // Start continuous rotation
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            // Background decorative elements
            _buildBackgroundDecorations(),
            // Main content
            Column(
              children: [
                // Top section and button with reduced spacing
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Top section with less vertical space
                      _buildTopSection(reduced: true),
                      // Center button
                      _buildCenterButton(),
                    ],
                  ),
                ),
                // Dog image takes all remaining space
                Expanded(
                  child: _buildBottomSection(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Top-right decorative circles
        Positioned(
          top: -30,
          right: -30,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.shade100.withOpacity(0.3),
            ),
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.orange.shade200.withOpacity(0.4),
            ),
          ),
        ),
        
        // Heart-shaped decorative elements
        Positioned(
          top: 150,
          left: 30,
          child: _buildHeartIcon(),
        ),
        Positioned(
          top: 200,
          right: 50,
          child: _buildHeartIcon(),
        ),
        Positioned(
          top: 300,
          left: 60,
          child: _buildHeartIcon(),
        ),
      ],
    );
  }

  Widget _buildHeartIcon() {
    return Icon(
      Icons.favorite,
      color: Colors.pink.shade200.withOpacity(0.3),
      size: 24,
    );
  }

  // Update _buildTopSection to accept reduced spacing
  Widget _buildTopSection({bool reduced = false}) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveHelper.responsiveValue(context, mobile: 10, tablet: 20),
        vertical: reduced
            ? ResponsiveHelper.responsiveValue(context, mobile: 4, tablet: 8)
            : ResponsiveHelper.responsiveValue(context, mobile: 10, tablet: 20),
      ),
      child: Column(
        children: [
          SizedBox(height: reduced 
              ? ResponsiveHelper.responsiveSpacing(context, mobile: 10, tablet: 20) 
              : ResponsiveHelper.responsiveSpacing(context, mobile: 30, tablet: 60)),
          // Main heading text
          Text(
            "Let's do\nsomething together",
            style: TextStyle(
              color: _textColor,
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 22, tablet: 32),
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: reduced 
              ? ResponsiveHelper.responsiveSpacing(context, mobile: 6, tablet: 12) 
              : ResponsiveHelper.responsiveSpacing(context, mobile: 16, tablet: 30)),
          // Description text
          Text(
            "Meet local dogs and dog lovers for\nfriendship, play-dates or fun outdoor playing.",
            style: TextStyle(
              color: _textColor.withOpacity(0.7),
              fontSize: ResponsiveHelper.responsiveFontSize(context, mobile: 13, tablet: 16),
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: reduced 
              ? ResponsiveHelper.responsiveSpacing(context, mobile: 8, tablet: 16) 
              : ResponsiveHelper.responsiveSpacing(context, mobile: 20, tablet: 40)),
        ],
      ),
    );
  }

  Widget _buildCenterButton() {
    final buttonSize = ResponsiveHelper.responsiveValue(context, mobile: 60.0, tablet: 80.0);
    final innerSize = ResponsiveHelper.responsiveValue(context, mobile: 44.0, tablet: 60.0);
    final iconSize = ResponsiveHelper.responsiveValue(context, mobile: 18.0, tablet: 24.0);
    return Container(
      padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.responsiveValue(context, mobile: 24, tablet: 40)),
      child: GestureDetector(
        onTap: _handleButtonTap,
        child: SizedBox(
          width: buttonSize,
          height: buttonSize,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Rotating circular border
              AnimatedBuilder(
                animation: _rotationAnimation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rotationAnimation.value * 2 * 3.141592653589793,
                    child: Container(
                      width: buttonSize,
                      height: buttonSize,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _circleColor,
                          width: 2,
                        ),
                      ),
                      child: CustomPaint(
                        painter: CircularBorderPainter(),
                      ),
                    ),
                  );
                },
              ),
              // Inner button with arrow
              Container(
                width: innerSize,
                height: innerSize,
                decoration: BoxDecoration(
                  color: _primaryColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: _primaryColor.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: iconSize,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSection() {
    return SizedBox.expand(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 30)),
          topRight: Radius.circular(ResponsiveHelper.responsiveBorderRadius(context, mobile: 30)),
        ),
        child: Image.asset(
          'assets/images/dog_onboarding.png',
          fit: BoxFit.contain,
          alignment: Alignment.bottomCenter,
        ),
      ),
    );
  }


  void _handleButtonTap() {
    Navigator.pushReplacementNamed(context, '/signin');
  }
}

// Custom painter for the rotating circular border
class CircularBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFF97316)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 4) / 2;

    // Draw a partial arc (about 1/4 of the circle)
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2, // Start from top
      3.141592653589793 / 2,  // Draw 1/4 circle
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}