// lib/presentation/widgets/calendar/calendar_navigation.dart
import 'package:flutter/material.dart';

class CalendarNavigation extends StatelessWidget {
  final DateTime currentDate;
  final ValueChanged<DateTime> onDateChanged;
  final VoidCallback onTodayPressed;
  final String viewType; // 'day', 'week', 'month', 'agenda'

  const CalendarNavigation({
    Key? key,
    required this.currentDate,
    required this.onDateChanged,
    required this.onTodayPressed,
    required this.viewType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Today button
          OutlinedButton(
            onPressed: onTodayPressed,
            child: const Text('Today'),
          ),
          const Spacer(),
          // Navigation arrows
          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: () => _navigate(-1),
          ),
          // Date display
          Text(
            _getDateDisplay(),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: () => _navigate(1),
          ),
        ],
      ),
    );
  }

  String _getDateDisplay() {
    switch (viewType) {
      case 'day':
        return '${currentDate.day} ${_getMonthName(currentDate.month)} ${currentDate.year}';
      case 'week':
        final weekStart = _getWeekStart(currentDate);
        final weekEnd = weekStart.add(const Duration(days: 6));
        return '${weekStart.day} ${_getMonthName(weekStart.month)} - ${weekEnd.day} ${_getMonthName(weekEnd.month)} ${weekEnd.year}';
      case 'month':
        return '${_getMonthName(currentDate.month)} ${currentDate.year}';
      case 'agenda':
        return '${_getMonthName(currentDate.month)} ${currentDate.year}';
      default:
        return '${currentDate.day} ${_getMonthName(currentDate.month)} ${currentDate.year}';
    }
  }

  DateTime _getWeekStart(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _navigate(int direction) {
    DateTime newDate;
    
    switch (viewType) {
      case 'day':
        newDate = currentDate.add(Duration(days: direction));
        break;
      case 'week':
        newDate = currentDate.add(Duration(days: direction * 7));
        break;
      case 'month':
        newDate = DateTime(currentDate.year, currentDate.month + direction);
        break;
      case 'agenda':
        newDate = currentDate.add(Duration(days: direction * 7));
        break;
      default:
        newDate = currentDate.add(Duration(days: direction));
    }
    
    onDateChanged(newDate);
  }
}