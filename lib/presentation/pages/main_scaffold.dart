// lib/presentation/pages/main_scaffold.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mylifetime/presentation/widgets/common/custom_bottom_nav_bar.dart';

class MainScaffold extends StatefulWidget {
  final Widget child;

  const MainScaffold({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: CustomBottomNavBar(currentIndex: _currentIndex),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateCurrentIndex();
  }

  void _updateCurrentIndex() {
    final location = GoRouterState.of(context).location;
    
    if (location == '/') {
      _currentIndex = 0;
    } else if (location.startsWith('/habits')) {
      _currentIndex = 1;
    } else if (location.startsWith('/goals')) {
      _currentIndex = 2;
    } else if (location.startsWith('/notes')) {
      _currentIndex = 3;
    } else if (location.startsWith('/pomodoro')) {
      _currentIndex = 4;
    } else {
      _currentIndex = 0;
    }
    
    if (mounted) {
      setState(() {});
    }
  }
}