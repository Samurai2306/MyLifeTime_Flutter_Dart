// lib/presentation/widgets/calendar/agenda_list.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mylifetime/domain/entities/event_entity.dart';
import 'package:mylifetime/presentation/blocs/event/event_bloc.dart';
import 'package:mylifetime/presentation/widgets/calendar/glass_event_card.dart';
import 'package:mylifetime/core/utils/date_utils.dart' as date_utils;

class AgendaList extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const AgendaList({
    Key? key,
    required this.startDate,
    required this.endDate,
  }) : super(key: key);

  @override
  State<AgendaList> createState() => _AgendaListState();
}

class _AgendaListState extends State<AgendaList> {
  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  void _loadEvents() {
    context.read<EventBloc>().add(LoadEvents(
      startDate: widget.startDate,
      endDate: widget.endDate,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventLoading) {
          return const LoadingIndicator();
        } else if (state is EventError) {
          return ErrorWidget(
            message: state.message,
            onRetry: _loadEvents,
          );
        } else if (state is EventsLoaded) {
          return _buildAgendaList(state.events);
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildAgendaList(List<EventEntity> events) {
    if (events.isEmpty) {
      return _buildEmptyState();
    }

    // Group events by date
    final eventsByDate = <DateTime, List<EventEntity>>{};
    for (final event in events) {
      final dateKey = date_utils.DateUtils.startOfDay(event.startDate);
      if (!eventsByDate.containsKey(dateKey)) {
        eventsByDate[dateKey] = [];
      }
      eventsByDate[dateKey]!.add(event);
    }

    // Sort dates
    final sortedDates = eventsByDate.keys.toList()..sort();

    return ListView.builder(
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        final date = sortedDates[index];
        final dayEvents = eventsByDate[date]!..sort((a, b) => a.startDate.compareTo(b.startDate));
        
        return _buildDateSection(date, dayEvents);
      },
    );
  }

  Widget _buildDateSection(DateTime date, List<EventEntity> events) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            _formatDateHeader(date),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...events.map((event) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
          child: GlassEventCard(
            title: event.title,
            description: event.description,
            color: Color(event.colorValue),
            startTime: event.startDate,
            endTime: event.endDate,
            isAllDay: event.isAllDay,
            onTap: () => _onEventTap(event),
            onLongPress: () => _onEventLongPress(event),
          ),
        )),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.event_note,
            size: 64,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No Events',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Events for this period will appear here',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    if (date_utils.DateUtils.isSameDay(date, now)) {
      return 'Today';
    } else if (date_utils.DateUtils.isSameDay(date, now.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else if (date_utils.DateUtils.isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else {
      return '${date.day} ${_getMonthName(date.month)} ${date.year}';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  void _onEventTap(EventEntity event) {
    // TODO: Navigate to event details
  }

  void _onEventLongPress(EventEntity event) {
    // TODO: Show context menu
  }
}