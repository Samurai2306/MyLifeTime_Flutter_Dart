// lib/core/constants/app_constants.dart
class AppConstants {
  static const String appName = 'MyLifeTime';
  static const String appVersion = '1.0.0';
  
  // Database
  static const String databaseName = 'mylifetime_db';
  static const int databaseVersion = 1;
  
  // Themes
  static const String lightTheme = 'light';
  static const String darkTheme = 'dark';
  static const String amoledTheme = 'amoled';
  
  // Backup
  static const String backupFileExtension = '.mylifetime';
  static const String csvFileExtension = '.csv';
  
  // Notifications
  static const String notificationChannelId = 'mylifetime_channel';
  static const String notificationChannelName = 'MyLifeTime Notifications';
  
  // Widgets
  static const int appWidgetUpdateInterval = 30; // minutes
}

class RouteConstants {
  static const String home = '/';
  static const String calendar = '/calendar';
  static const String habits = '/habits';
  static const String goals = '/goals';
  static const String notes = '/notes';
  static const String pomodoro = '/pomodoro';
  static const String settings = '/settings';
  static const String eventForm = '/event/form';
  static const String habitForm = '/habit/form';
  static const String goalForm = '/goal/form';
  static const String noteForm = '/note/form';
}