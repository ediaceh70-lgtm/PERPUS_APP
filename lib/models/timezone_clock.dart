import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../config/theme.dart';

class TimeZoneModel {
  final String name;
  final String timezone;
  final String code;

  TimeZoneModel({
    required this.name,
    required this.timezone,
    required this.code,
  });
}

class TimeZoneClock {
  final TimeZoneModel timeZone;
  late DateTime currentTime;

  TimeZoneClock({required this.timeZone}) {
    updateTime();
  }

  void updateTime() {
    final now = DateTime.now();
    final timeZoneOffset = _getTimeZoneOffset(timeZone.timezone);
    currentTime = now.add(Duration(hours: timeZoneOffset));
  }

  int _getTimeZoneOffset(String timezone) {
    try {
      final location = _parseTimeZone(timezone);
      final now = DateTime.now();
      final offset = now.timeZoneOffset;
      final targetOffset = _getTargetOffset(location);
      return targetOffset - offset.inHours;
    } catch (e) {
      return 0;
    }
  }

  String _parseTimeZone(String timezone) {
    return timezone;
  }

  int _getTargetOffset(String location) {
    final offsets = {
      'Asia/Jakarta': 7,
      'Asia/Bangkok': 7,
      'Asia/Ho_Chi_Minh': 7,
      'Asia/Manila': 8,
      'Asia/Shanghai': 8,
      'Asia/Hong_Kong': 8,
      'Asia/Tokyo': 9,
      'Asia/Seoul': 9,
      'Australia/Sydney': 11,
      'Pacific/Auckland': 13,
      'UTC': 0,
      'Europe/London': 0,
      'Europe/Paris': 1,
      'Europe/Berlin': 1,
      'Europe/Moscow': 3,
      'America/New_York': -5,
      'America/Chicago': -6,
      'America/Denver': -7,
      'America/Los_Angeles': -8,
      'America/Anchorage': -9,
      'Pacific/Honolulu': -10,
    };
    return offsets[location] ?? 0;
  }

  String getFormattedTime(String format) {
    return DateFormat(format).format(currentTime);
  }

  String get formattedTime => getFormattedTime('HH:mm:ss');
  String get formattedDate => getFormattedTime('EEE, MMM dd, yyyy');
  String get period => currentTime.hour >= 12 ? 'PM' : 'AM';
  String get hour12 => getFormattedTime('hh');
  String get minute => getFormattedTime('mm');
  String get second => getFormattedTime('ss');
}