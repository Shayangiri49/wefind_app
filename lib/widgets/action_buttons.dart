import 'package:flutter/material.dart';
import 'package:wefind_app/utils/responsive_helper.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onCross;
  final VoidCallback onHeart;
  final VoidCallback onStar;

  const ActionButtons({
    Key? key,
    required this.onCross,
    required this.onHeart,
    required this.onStar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ActionButton(
          icon: Icons.close,
          color: Colors.red,
          onTap: onCross,
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 4)), // Minimal gap
        _ActionButton(
          icon: Icons.favorite,
          color: Colors.pink,
          onTap: onHeart,
        ),
        SizedBox(width: ResponsiveHelper.responsiveSpacing(context, mobile: 4)), // Minimal gap
        _ActionButton(
          icon: Icons.star,
          color: Colors.amber,
          onTap: onStar,
        ),
      ],
    );
  }
}

class _ActionButton extends StatefulWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _animationController.forward(),
      onTapUp: (_) => _animationController.reverse(),
      onTapCancel: () => _animationController.reverse(),
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              width: ResponsiveHelper.responsiveValue(context, mobile: 56),
              height: ResponsiveHelper.responsiveValue(context, mobile: 56),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                widget.icon,
                color: widget.color,
                size: ResponsiveHelper.responsiveIconSize(context, mobile: 28),
              ),
            ),
          );
        },
      ),
    );
  }
}
