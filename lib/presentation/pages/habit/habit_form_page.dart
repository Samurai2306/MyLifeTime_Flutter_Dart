// lib/presentation/pages/habit/habit_form_page.dart
import 'package:flutter/material.dart';

class HabitFormPage extends StatelessWidget {
  final int? habitId;

  const HabitFormPage({Key? key, this.habitId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(habitId == null ? 'New Habit' : 'Edit Habit'),
      ),
      body: const Center(
        child: Text('Habit Form - To be implemented'),
      ),
    );
  }
}