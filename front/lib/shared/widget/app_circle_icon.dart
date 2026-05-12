import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class AppCircleIcon extends StatelessWidget {

  const AppCircleIcon({
    super.key,
    required this.icon,
    this.size = 84,
    this.iconSize = 42,
    this.backgroundColor = AppColors.primary,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final double size;
  final double iconSize;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}