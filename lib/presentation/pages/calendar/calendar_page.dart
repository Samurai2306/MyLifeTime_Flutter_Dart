// presentation/pages/calendar/calendar_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> 
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late TabController _tabController;
  final DateTime _currentDate = DateTime.now();

  final List<Widget> _calendarViews = [
    DayViewPage(),
    WeekViewPage(),
    MonthViewPage(),
    AgendaViewPage(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
    _tabController = TabController(length: 4, vsync: this);
    
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      _pageController.animateToPage(
        _tabController.index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(
                _formatAppBarTitle(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              floating: true,
              snap: true,
              pinned: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.today),
                  onPressed: _jumpToToday,
                  tooltip: 'Go to today',
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _openSearch,
                  tooltip: 'Search events',
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: _openFilters,
                  tooltip: 'Filter events',
                ),
              ],
              bottom: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'Day'),
                  Tab(text: 'Week'),
                  Tab(text: 'Month'),
                  Tab(text: 'Agenda'),
                ],
                labelStyle: Theme.of(context).textTheme.labelLarge,
                indicatorSize: TabBarIndicatorSize.tab,
              ),
            ),
          ];
        },
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
          children: _calendarViews,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEvent,
        child: const Icon(Icons.add),
      ),
    );
  }

  String _formatAppBarTitle() {
    final format = _tabController.index == 2 
        ? 'MMMM yyyy' 
        : 'MMM d, yyyy';
    return _currentDate.toString();
  }

  void _jumpToToday() {
    setState(() {
      // Implementation for jumping to today
    });
  }

  void _openSearch() {
    // Implementation for search
  }

  void _openFilters() {
    // Implementation for filters
  }

  void _addNewEvent() {
    // Implementation for adding new event
  }

  @override
  void dispose() {
    _pageController.dispose();
    _tabController.dispose();
    super.dispose();
  }
}