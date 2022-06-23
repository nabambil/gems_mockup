import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

import 'package:table_calendar/table_calendar.dart';

import 'bloc.dart';

class BlocAttendance extends Bloc {
  final BehaviorSubject<TabController> _tabController = BehaviorSubject();
  final BehaviorSubject<DateTime> _calendarDay =
      BehaviorSubject<DateTime>.seeded(DateTime.now());
  final BehaviorSubject<LinkedHashMap<DateTime, List<Event>>> _kEvents =
      BehaviorSubject<LinkedHashMap<DateTime, List<Event>>>();
  final BehaviorSubject<Event> _kEvent = BehaviorSubject<Event>();

  final _kEventSource = Map<DateTime, List<Event>>();

  BlocAttendance() {
    final DateTime kToday = DateTime.now();
    final _kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    final f = DateFormat('dd-MM-yyyy');
    _kEventSource.addAll(Map.fromIterable(
      List.generate(50, (index) => index),
      key: (item) => DateTime.utc(_kFirstDay.year, _kFirstDay.month, item * 5),
      value: (item) => [
        Event(f
            .format(DateTime.utc(_kFirstDay.year, _kFirstDay.month, item * 5))
            .toString())
      ],
    )..addAll({
        kToday: [Event(f.format(DateTime.now()))]
      }));
    _kEvents.sink.add(LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(_kEventSource));

    _calendarDay.listen((value) {
      final events = _kEvents.value[value];
      _kEvent.sink.add(events != null ? events.first : null);
    });
  }

  set tabController(TabController value) => _tabController.sink.add(value);
  get tab => _tabController.value;

  set selected(DateTime value) => _calendarDay.sink.add(value);
  get calendarDate$ => _calendarDay.stream;

  get events$ => _kEvents.stream;
  get event$ => _kEvent.stream;

  @override
  void dispose() {
    _tabController.value.dispose();
    _tabController.close();
    _calendarDay.close();
    _kEvents.close();
    _kEvent.close();
    super.dispose();
  }

  List<Event> getEventsForDay(DateTime day) {
    return _kEvents.value[day] ?? [];
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}
