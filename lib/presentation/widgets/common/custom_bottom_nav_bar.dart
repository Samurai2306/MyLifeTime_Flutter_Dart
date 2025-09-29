// lib/presentation/widgets/common/custom_bottom_nav_bar.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onItemTapped(context, index),
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.psychology),
          label: 'Habits',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.flag),
          label: 'Goals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Notes',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Focus',
        ),
      ],
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/habits');
        break;
      case 2:
        context.go('/goals');
        break;
      case 3:
        context.go('/notes');
        break;
      case 4:
        context.go('/pomodoro');
        break;
    }
  }
}