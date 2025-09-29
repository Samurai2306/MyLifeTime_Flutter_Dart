// lib/presentation/pages/habits/habits_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/presentation/blocs/habit/habit_bloc.dart';
import 'package:mylifetime/presentation/widgets/habits/habit_card.dart';

class HabitsPage extends StatefulWidget {
  const HabitsPage({Key? key}) : super(key: key);

  @override
  State<HabitsPage> createState() => _HabitsPageState();
}

class _HabitsPageState extends State<HabitsPage> {
  @override
  void initState() {
    super.initState();
    context.read<HabitBloc>().add(LoadHabits());
  }

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
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          
          if (state is HabitsLoaded) {
            final habits = state.habits;
            
            if (habits.isEmpty) {
              return _buildEmptyState();
            }
            
            return _buildHabitsGrid(habits);
          }
          
          return const Center(child: Text('Failed to load habits'));
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.psychology_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No Habits Yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Start building your habits by adding your first one',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => _showAddHabitDialog(context),
            child: const Text('Add First Habit'),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitsGrid(List<HabitEntity> habits) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: habits.length,
      itemBuilder: (context, index) => HabitCard(
        habit: habits[index],
        onTap: () => _showHabitDetails(context, habits[index]),
        onLongPress: () => _showHabitOptions(context, habits[index]),
      ),
    );
  }

  void _showAddHabitDialog(BuildContext context) {
    // TODO: Реализовать диалог добавления привычки
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

  void _showHabitDetails(BuildContext context, HabitEntity habit) {
    // TODO: Реализовать детали привычки
  }

  void _showHabitOptions(BuildContext context, HabitEntity habit) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit Habit'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Реализовать редактирование привычки
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete Habit'),
            onTap: () {
              Navigator.of(context).pop();
              _showDeleteConfirmation(context, habit);
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, HabitEntity habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: Text('Are you sure you want to delete "${habit.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<HabitBloc>().add(DeleteHabitEvent(habitId: habit.id));
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}