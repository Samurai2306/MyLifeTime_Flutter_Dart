// lib/presentation/widgets/habits/habit_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/domain/entities/habit_entity.dart';
import 'package:mylifetime/presentation/blocs/habit/habit_bloc.dart';

class HabitCard extends StatelessWidget {
  final HabitEntity habit;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const HabitCard({
    Key? key,
    required this.habit,
    this.onTap,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(habit.colorValue).withOpacity(0.3),
                Color(habit.colorValue).withOpacity(0.1),
              ],
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      habit.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildCompletionToggle(context),
                ],
              ),
              
              if (habit.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  habit.description!,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              
              const Spacer(),
              
              _buildHabitStats(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompletionToggle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final today = DateTime.now();
        final isCompletedToday = habit.isCompletedToday;
        
        context.read<HabitBloc>().add(
          MarkHabitCompletedEvent(
            habitId: habit.id,
            date: today,
            completed: !isCompletedToday,
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: habit.isCompletedToday 
              ? Color(habit.colorValue).withOpacity(0.8)
              : Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: Color(habit.colorValue),
            width: 2,
          ),
        ),
        child: habit.isCompletedToday
            ? Icon(
                Icons.check,
                size: 16,
                color: Colors.white,
              )
            : null,
      ),
    );
  }

  Widget _buildHabitStats() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem('${habit.currentStreak}', 'Day Streak'),
        _buildStatItem('${habit.completionRate}%', 'Completion'),
        _buildStatItem(habit.frequency, 'Frequency'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 10,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}