// presentation/pages/habits/habits_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Habits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddHabitDialog(context),
          ),
        ],
      ),
      body: _buildHabitsGrid(),
    );
  }

  Widget _buildHabitsGrid() {
    // TODO: Заменить на реальные данные из BLoC
    final habits = [
      _createSampleHabit('Morning Run', Colors.green),
      _createSampleHabit('Read Book', Colors.blue),
      _createSampleHabit('Meditation', Colors.purple),
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: habits.length,
      itemBuilder: (context, index) => _HabitCard(habit: habits[index]),
    );
  }

  Map<String, dynamic> _createSampleHabit(String title, Color color) {
    return {
      'title': title,
      'color': color,
      'completed': false,
      'streak': 7,
    };
  }

  void _showAddHabitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Habit'),
        content: const Text('Habit creation form will be implemented here'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _HabitCard extends StatelessWidget {
  final Map<String, dynamic> habit;

  const _HabitCard({Key? key, required this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => _toggleHabit(context),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                habit['color'].withOpacity(0.3),
                habit['color'].withOpacity(0.1),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                habit['title'],
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Icon(
                    habit['completed'] ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: habit['completed'] ? Colors.green : Colors.grey,
                  ),
                  const SizedBox(width: 8),
                  Text('${habit['streak']} day streak'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleHabit(BuildContext context) {
    // TODO: Реализовать переключение статуса привычки
  }
}