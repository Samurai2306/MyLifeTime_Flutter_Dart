// lib/presentation/pages/calendar/calendar_page.dart - ОБНОВЛЕННЫЙ
import 'package:flutter/material.dart';
import 'package:mylifetime/presentation/widgets/calendar/calendar_navigation.dart';
import 'package:mylifetime/presentation/widgets/calendar/day_view_page.dart';
import 'package:mylifetime/presentation/widgets/calendar/week_calendar.dart';
import 'package:mylifetime/presentation/widgets/calendar/month_calendar.dart';
import 'package:mylifetime/presentation/widgets/calendar/agenda_list.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late DateTime _currentDate;
  final List<String> _tabTitles = ['Day', 'Week', 'Month', 'Agenda'];

  @override
  void initState() {
    super.initState();
    _currentDate = DateTime.now();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _openSearch,
            tooltip: 'Search events',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewEvent,
            tooltip: 'Add new event',
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
        ),
      ),
      body: Column(
        children: [
          CalendarNavigation(
            currentDate: _currentDate,
            onDateChanged: (newDate) => setState(() => _currentDate = newDate),
            onTodayPressed: () => setState(() => _currentDate = DateTime.now()),
            viewType: _getCurrentViewType(),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                DayViewPage(currentDate: _currentDate),
                WeekCalendar(currentDate: _currentDate),
                MonthCalendar(currentDate: _currentDate),
                AgendaList(
                  startDate: DateTime(_currentDate.year, _currentDate.month, 1),
                  endDate: DateTime(_currentDate.year, _currentDate.month + 1, 0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getCurrentViewType() {
    switch (_tabController.index) {
      case 0: return 'day';
      case 1: return 'week';
      case 2: return 'month';
      case 3: return 'agenda';
      default: return 'day';
    }
  }

  void _openSearch() {
    // TODO: Implement search
  }

  void _addNewEvent() {
    // TODO: Navigate to event form
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}