// lib/presentation/widgets/common/glass_container.dart
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurIntensity;
  final Color baseColor;
  final double opacity;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Border? border;

  const GlassContainer({
    Key? key,
    required this.child,
    this.borderRadius = 12.0,
    this.blurIntensity = 10.0,
    this.baseColor = Colors.white,
    this.opacity = 0.1,
    this.padding = const EdgeInsets.all(16.0),
    this.margin,
    this.onTap,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Stack(
          children: [
            // Blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: blurIntensity,
                sigmaY: blurIntensity,
              ),
              child: Container(),
            ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
                border: border ?? Border.all(
                  color: baseColor.withOpacity(0.2),
                  width: 1.0,
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    baseColor.withOpacity(opacity),
                    baseColor.withOpacity(opacity * 0.7),
                  ],
                ),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Padding(
                    padding: padding,
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}