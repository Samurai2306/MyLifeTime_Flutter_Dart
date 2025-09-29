// lib/presentation/pages/goals/goals_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/presentation/blocs/goal/goal_bloc.dart';
import 'package:mylifetime/domain/entities/goal_entity.dart';
import 'package:mylifetime/presentation/widgets/common/glass_container.dart';
import 'package:mylifetime/presentation/widgets/common/loading_indicator.dart';
import 'package:mylifetime/presentation/widgets/common/error_widget.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  @override
  void initState() {
    super.initState();
    context.read<GoalBloc>().add(LoadGoals());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Goals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewGoal,
          ),
        ],
      ),
      body: BlocConsumer<GoalBloc, GoalState>(
        listener: (context, state) {
          if (state is GoalOperationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            context.read<GoalBloc>().add(LoadGoals());
          } else if (state is GoalError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is GoalLoading) {
            return const LoadingIndicator();
          } else if (state is GoalsLoaded) {
            return _buildGoalsList(state.goals);
          } else if (state is GoalError) {
            return ErrorWidget(
              message: state.message,
              onRetry: () => context.read<GoalBloc>().add(LoadGoals()),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildGoalsList(List<GoalEntity> goals) {
    if (goals.isEmpty) {
      return _buildEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: goals.length,
      itemBuilder: (context, index) {
        final goal = goals[index];
        return _buildGoalCard(goal);
      },
    );
  }

  Widget _buildGoalCard(GoalEntity goal) {
    final completedMilestones = goal.milestones.where((m) => m.isCompleted).length;
    final totalMilestones = goal.milestones.length;
    final progress = totalMilestones > 0 ? completedMilestones / totalMilestones : 0.0;

    return GlassContainer(
      margin: const EdgeInsets.only(bottom: 16),
      onTap: () => _showGoalDetails(goal),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  goal.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              _buildProgressCircle(progress),
            ],
          ),
          
          if (goal.description != null) ...[
            const SizedBox(height: 8),
            Text(
              goal.description!,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          
          const SizedBox(height: 12),
          _buildProgressBar(progress),
          
          const SizedBox(height: 8),
          _buildMilestonesInfo(goal),
          
          const SizedBox(height: 8),
          _buildGoalDates(goal),
        ],
      ),
    );
  }

  Widget _buildProgressCircle(double progress) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(
            value: progress,
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getProgressColor(progress),
            ),
          ),
        ),
        Text(
          '${(progress * 100).round()}%',
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(double progress) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      valueColor: AlwaysStoppedAnimation<Color>(
        _getProgressColor(progress),
      ),
    );
  }

  Widget _buildMilestonesInfo(GoalEntity goal) {
    final completed = goal.milestones.where((m) => m.isCompleted).length;
    final total = goal.milestones.length;

    return Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          '$completed of $total milestones completed',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildGoalDates(GoalEntity goal) {
    final now = DateTime.now();
    final daysRemaining = goal.targetDate.difference(now).inDays;

    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        const SizedBox(width: 4),
        Text(
          'Target: ${_formatDate(goal.targetDate)}',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const Spacer(),
        Text(
          daysRemaining > 0 ? '$daysRemaining days left' : 'Overdue',
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            color: daysRemaining > 0 ? null : Colors.red,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No Goals Yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Set your first goal to start tracking your progress',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addNewGoal,
            child: const Text('Set Your First Goal'),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double progress) {
    if (progress < 0.3) return Colors.red;
    if (progress < 0.7) return Colors.orange;
    return Colors.green;
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _addNewGoal() {
    // TODO: Navigate to goal form
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New Goal'),
        content: const Text('Goal creation form will be implemented here'),
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

  void _showGoalDetails(GoalEntity goal) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(goal.title),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: [
              if (goal.description != null) ...[
                Text(goal.description!),
                const SizedBox(height: 16),
              ],
              ...goal.milestones.map((milestone) => _buildMilestoneTile(milestone)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildMilestoneTile(GoalMilestone milestone) {
    return ListTile(
      leading: Checkbox(
        value: milestone.isCompleted,
        onChanged: (value) {
          // TODO: Implement milestone toggle
        },
      ),
      title: Text(milestone.title),
      subtitle: milestone.description != null ? Text(milestone.description!) : null,
    );
  }
}