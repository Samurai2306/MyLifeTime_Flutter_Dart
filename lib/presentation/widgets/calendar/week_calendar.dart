// lib/presentation/widgets/calendar/week_calendar.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/presentation/blocs/event/event_bloc.dart';
import 'package:mylifetime/presentation/widgets/calendar/glass_event_card.dart';
import 'package:mylifetime/core/utils/date_utils.dart' as date_utils;

class WeekCalendar extends StatefulWidget {
  final DateTime currentDate;

  const WeekCalendar({Key? key, required this.currentDate}) : super(key: key);

  @override
  State<WeekCalendar> createState() => _WeekCalendarState();
}

class _WeekCalendarState extends State<WeekCalendar> {
  late DateTime _currentWeekStart;

  @override
  void initState() {
    super.initState();
    _currentWeekStart = date_utils.DateUtils.startOfWeek(widget.currentDate);
    _loadEvents();
  }

  void _loadEvents() {
    final start = _currentWeekStart;
    final end = date_utils.DateUtils.endOfWeek(_currentWeekStart);
    
    context.read<EventBloc>().add(LoadEvents(
      startDate: start,
      endDate: end,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildWeekHeader(),
        Expanded(
          child: BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventsLoaded) {
                return _buildWeekGrid(state.events);
              } else if (state is EventError) {
                return ErrorWidget(
                  message: state.message,
                  onRetry: _loadEvents,
                );
              }
              return const LoadingIndicator();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerColor,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: List.generate(7, (index) {
          final day = _currentWeekStart.add(Duration(days: index));
          final isToday = date_utils.DateUtils.isSameDay(day, DateTime.now());
          
          return Expanded(
            child: Column(
              children: [
                Text(
                  _getWeekdayAbbreviation(day.weekday),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 32,
                  height: 32,
                  decoration: isToday
                      ? BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        )
                      : null,
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isToday
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildWeekGrid(List<EventEntity> events) {
    return Row(
      children: List.generate(7, (dayIndex) {
        final currentDay = _currentWeekStart.add(Duration(days: dayIndex));
        final dayEvents = events.where((event) {
          return date_utils.DateUtils.isSameDay(event.startDate, currentDay);
        }).toList();

        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: dayIndex < 6
                    ? BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      )
                    : BorderSide.none,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: dayEvents.length,
                    itemBuilder: (context, index) {
                      final event = dayEvents[index];
                      return GlassEventCard(
                        title: event.title,
                        description: event.description,
                        color: Color(event.colorValue),
                        startTime: event.startDate,
                        endTime: event.endDate,
                        isAllDay: event.isAllDay,
                        onTap: () => _onEventTap(event),
                        onLongPress: () => _onEventLongPress(event),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  String _getWeekdayAbbreviation(int weekday) {
    const abbreviations = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return abbreviations[weekday - 1];
  }

  void _onEventTap(EventEntity event) {
    // TODO: Navigate to event details
  }

  void _onEventLongPress(EventEntity event) {
    // TODO: Show context menu
  }
}