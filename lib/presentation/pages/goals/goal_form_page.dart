// lib/presentation/pages/goal/goal_form_page.dart
import 'package:flutter/material.dart';

class GoalFormPage extends StatelessWidget {
  final int? goalId;

  const GoalFormPage({Key? key, this.goalId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(goalId == null ? 'New Goal' : 'Edit Goal'),
      ),
      body: const Center(
        child: Text('Goal Form - To be implemented'),
      ),
    );
  }
}