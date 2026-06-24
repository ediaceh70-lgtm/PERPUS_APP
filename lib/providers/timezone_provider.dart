import 'package:flutter/material.dart';
import '../models/timezone_clock.dart';

class TimeZoneProvider extends ChangeNotifier {
  List<TimeZoneClock> _clocks = [];
  bool _is24HourFormat = true;

  List<TimeZoneClock> get clocks => _clocks;
  bool get is24HourFormat => _is24HourFormat;

  final List<TimeZoneModel> availableTimeZones = [
    TimeZoneModel(name: 'Jakarta', timezone: 'Asia/Jakarta', code: 'WIB'),
    TimeZoneModel(name: 'Bangkok', timezone: 'Asia/Bangkok', code: 'ICT'),
    TimeZoneModel(name: 'Manila', timezone: 'Asia/Manila', code: 'PHT'),
    TimeZoneModel(name: 'Shanghai', timezone: 'Asia/Shanghai', code: 'CST'),
    TimeZoneModel(name: 'Hong Kong', timezone: 'Asia/Hong_Kong', code: 'HKT'),
    TimeZoneModel(name: 'Tokyo', timezone: 'Asia/Tokyo', code: 'JST'),
    TimeZoneModel(name: 'Seoul', timezone: 'Asia/Seoul', code: 'KST'),
    TimeZoneModel(name: 'Sydney', timezone: 'Australia/Sydney', code: 'AEDT'),
    TimeZoneModel(name: 'Auckland', timezone: 'Pacific/Auckland', code: 'NZDT'),
    TimeZoneModel(name: 'UTC', timezone: 'UTC', code: 'UTC'),
    TimeZoneModel(name: 'London', timezone: 'Europe/London', code: 'GMT'),
    TimeZoneModel(name: 'Paris', timezone: 'Europe/Paris', code: 'CET'),
    TimeZoneModel(name: 'Berlin', timezone: 'Europe/Berlin', code: 'CET'),
    TimeZoneModel(name: 'Moscow', timezone: 'Europe/Moscow', code: 'MSK'),
    TimeZoneModel(name: 'New York', timezone: 'America/New_York', code: 'EST'),
    TimeZoneModel(name: 'Chicago', timezone: 'America/Chicago', code: 'CST'),
    TimeZoneModel(name: 'Denver', timezone: 'America/Denver', code: 'MST'),
    TimeZoneModel(name: 'Los Angeles', timezone: 'America/Los_Angeles', code: 'PST'),
    TimeZoneModel(name: 'Anchorage', timezone: 'America/Anchorage', code: 'AKST'),
    TimeZoneModel(name: 'Honolulu', timezone: 'Pacific/Honolulu', code: 'HST'),
  ];

  TimeZoneProvider() {
    _initializeDefaultClocks();
  }

  void _initializeDefaultClocks() {
    _clocks = [
      TimeZoneClock(timeZone: availableTimeZones[0]), // Jakarta
      TimeZoneClock(timeZone: availableTimeZones[5]), // Tokyo
      TimeZoneClock(timeZone: availableTimeZones[14]), // New York
    ];
    notifyListeners();
  }

  void addClock(TimeZoneModel timeZone) {
    if (!_clocks.any((c) => c.timeZone.timezone == timeZone.timezone)) {
      _clocks.add(TimeZoneClock(timeZone: timeZone));
      notifyListeners();
    }
  }

  void removeClock(int index) {
    if (index >= 0 && index < _clocks.length) {
      _clocks.removeAt(index);
      notifyListeners();
    }
  }

  void toggleTimeFormat() {
    _is24HourFormat = !_is24HourFormat;
    notifyListeners();
  }

  void updateAllClocks() {
    for (var clock in _clocks) {
      clock.updateTime();
    }
    notifyListeners();
  }
}