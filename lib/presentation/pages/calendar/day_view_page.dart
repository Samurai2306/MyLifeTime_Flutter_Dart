// presentation/pages/calendar/day_view_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DayViewPage extends StatelessWidget {
  const DayViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _buildHourlyGrid(),
        ),
      ],
    );
  }

  Widget _buildHourlyGrid() {
    return SizedBox(
      height: 24 * 60, // 24 hours * 60 pixels per hour
      child: Stack(
        children: [
          // Hour lines
          Column(
            children: List.generate(24, (hour) {
              return Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${hour.toString().padLeft(2, '0')}:00',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
          // Events will be positioned absolutely
          BlocBuilder<EventBloc, EventState>(
            builder: (context, state) {
              if (state is EventsLoaded) {
                return _buildEventsOverlay(state.events);
              }
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildEventsOverlay(List<EventEntity> events) {
    return Stack(
      children: events.map((event) {
        return _buildEventPositioned(event);
      }).toList(),
    );
  }

  Widget _buildEventPositioned(EventEntity event) {
    // Calculate position based on event time
    final startHour = event.startDate.hour + event.startDate.minute / 60;
    final endHour = event.endDate.hour + event.endDate.minute / 60;
    final duration = endHour - startHour;

    return Positioned(
      top: startHour * 60,
      left: 60, // Offset for time labels
      right: 8,
      height: duration * 60,
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
    );
  }

  void _onEventTap(EventEntity event) {
    // Navigate to event details
  }

  void _onEventLongPress(EventEntity event) {
    // Show context menu
  }
}