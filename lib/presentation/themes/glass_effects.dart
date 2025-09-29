// presentation/themes/glass_effects.dart
import 'package:flutter/material.dart';

class GlassEffects {
  static const glassFilter = ImageFilter.blur(sigmaX: 10, sigmaY: 10);
  
  static BoxDecoration glassDecoration({
    Color baseColor = Colors.white,
    double opacity = 0.1,
    BorderRadius borderRadius = BorderRadius.zero,
    Border? border,
  }) {
    return BoxDecoration(
      borderRadius: borderRadius,
      border: border ?? Border.all(color: baseColor.withOpacity(0.2)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          baseColor.withOpacity(opacity),
          baseColor.withOpacity(opacity * 0.7),
        ],
      ),
    );
  }
}