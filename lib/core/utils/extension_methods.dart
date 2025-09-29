// lib/core/utils/extension_methods.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
    );
  }

  String toTimeString() {
    return DateFormat('HH:mm').format(this);
  }

  String toDateString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toDateTimeString() {
    return DateFormat('yyyy-MM-dd HH:mm').format(this);
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  bool isToday() {
    return isSameDay(DateTime.now());
  }
}

extension ColorExtension on Color {
  Color withBrightness(double factor) {
    assert(factor >= 0 && factor <= 1);
    
    final hsl = HSLColor.fromColor(this);
    final newLightness = hsl.lightness * factor;
    
    return hsl.withLightness(newLightness.clamp(0.0, 1.0)).toColor();
  }

  String toHexString() {
    return '#${value.toRadixString(16).padLeft(8, '0')}';
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  DateTime? toDateTime() {
    try {
      return DateTime.parse(this);
    } catch (e) {
      return null;
    }
  }
}

extension ListExtension<T> on List<T> {
  List<T> sortedBy<R extends Comparable>(R Function(T) selector) {
    return [...this]..sort((a, b) => selector(a).compareTo(selector(b)));
  }
}