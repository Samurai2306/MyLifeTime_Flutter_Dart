// lib/presentation/widgets/common/custom_app_bar.dart
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double elevation;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.actions,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.elevation = 0,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      backgroundColor: backgroundColor ?? Theme.of(context).appBarTheme.backgroundColor,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
    );
  }
}