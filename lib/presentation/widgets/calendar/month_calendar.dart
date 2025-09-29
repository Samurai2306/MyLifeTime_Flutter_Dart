// lib/presentation/widgets/calendar/month_calendar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/presentation/blocs/event/event_bloc.dart';
import 'package:mylifetime/core/utils/date_utils.dart' as date_utils;

class MonthCalendar extends StatefulWidget {
  final DateTime currentDate;

  const MonthCalendar({Key? key, required this.currentDate}) : super(key: key);

  @override
  State<MonthCalendar> createState() => _MonthCalendarState();
}

class _MonthCalendarState extends State<MonthCalendar> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.currentDate.year, widget.currentDate.month);
    _loadEvents();
  }

  void _loadEvents() {
    final start = date_utils.DateUtils.startOfMonth(_currentMonth);
    final end = date_utils.DateUtils.endOfMonth(_currentMonth);
    
    context.read<EventBloc>().add(LoadEvents(
      startDate: start,
      endDate: end,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        final events = state is EventsLoaded ? state.events : [];
        return _buildMonthGrid(events);
      },
    );
  }

  Widget _buildMonthGrid(List<EventEntity> events) {
    final firstDayOfMonth = DateTime(_currentMonth.year, _currentMonth.month);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    
    final totalCells = ((firstWeekday - 1) + daysInMonth + 6) ~/ 7 * 7;
    
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.2,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        final dayOffset = index - (firstWeekday - 1);
        final isCurrentMonth = dayOffset >= 0 && dayOffset < daysInMonth;
        
        if (!isCurrentMonth) {
          return Container(); // Empty cell for days outside current month
        }
        
        final currentDay = firstDayOfMonth.add(Duration(days: dayOffset));
        final dayEvents = events.where((event) {
          return date_utils.DateUtils.isSameDay(event.startDate, currentDay);
        }).toList();
        
        final isToday = date_utils.DateUtils.isSameDay(currentDay, DateTime.now());
        
        return _buildDayCell(currentDay, dayEvents, isToday);
      },
    );
  }

  Widget _buildDayCell(DateTime day, List<EventEntity> events, bool isToday) {
    return Container(
      margin: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        border: isToday
            ? Border.all(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              )
            : Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.3),
              ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () => _onDayTap(day),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day.day.toString(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                    color: isToday
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 2),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: events.length > 3 ? 3 : events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return Container(
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 1),
                        decoration: BoxDecoration(
                          color: Color(event.colorValue),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      );
                    },
                  ),
                ),
                if (events.length > 3)
                  Text(
                    '+${events.length - 3}',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onDayTap(DateTime day) {
    // TODO: Navigate to day view
  }
}