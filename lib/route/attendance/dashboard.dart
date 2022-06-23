import 'package:flutter/material.dart';
import 'package:mockup_gems/utils/bloc/bloc_attendance.dart';
import 'package:mockup_gems/utils/constant.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> with TickerProviderStateMixin {
  final BlocAttendance _bloc = BlocAttendance();

  final f = DateFormat('hh:mm:ss a');
  String _timeClockIn;
  String _timeClockOut;
  String _duration;
  String _timeString;
  Timer _timer;

  void clockedIn() {
    setState(() => _timeClockIn = f.format(DateTime.now()));
  }

  void clockedOut() {
    setState(() {
      _timeClockOut = f.format(DateTime.now());
      duration();
    });
  }

  void duration() {
    final t1 = DateTime.parse("2021-09-09 " + _timeClockIn.substring(0, 8));
    final t2 = DateTime.parse("2021-09-09 " + _timeClockOut.substring(0, 8));

    final d = t2.difference(t1);
    String sDuration =
        "${d.inHours} Hours ${d.inMinutes.remainder(60)} Minutes ${(d.inSeconds.remainder(60))} Seconds";

    _duration = sDuration;
  }

  void clear() {
    setState(() {
      _timeClockIn = null;
      _timeClockOut = null;
      _duration = null;
    });
  }

  bool get checkin => _timeClockIn == null;
  bool get checkout => _timeClockOut == null;

  _DashboardState() {
    _bloc.tabController = TabController(length: 2, vsync: this);
    _timeString = f.format(DateTime.now());
    _timer = Timer.periodic(Duration(seconds: 1),
        (Timer t) => setState(() => _timeString = f.format(DateTime.now())));
  }

  @override
  void dispose() {
    _bloc.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Attendance"),
          centerTitle: true,
          bottom: TabBar(
            controller: _bloc.tab,
            tabs: [Tab(text: "Calendar"), Tab(text: "Weekly Progress")],
          )),
      body: TabBarView(
        controller: _bloc.tab,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [_Calendar(_bloc), _Details(_bloc.event$)],
            ),
          ),
          ProgressClock(_timeString, _timeClockIn, _timeClockOut, _duration),
        ],
      ),
      floatingActionButton: Row(
        children: [
          SizedBox(width: 32),
          FloatingActionButton.extended(
            onPressed: () => clear(),
            label: _TextCell("Apply OT"),
            backgroundColor: colorTheme1,
          ),
          Spacer(),
          if (checkout)
            FloatingActionButton.extended(
                backgroundColor: checkin ? colorTheme3 : colorTheme4,
                onPressed: () {
                  if (checkin == false) {
                    clockedOut();
                  } else {
                    clockedIn();
                  }
                },
                label: _TextCell(checkin ? "Clock In" : "Clock Out")),
        ],
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  final BlocAttendance _bloc;
  final DateTime kToday = DateTime.now();
  DateTime _kFirstDay;
  DateTime _kLastDay;

  _Calendar(this._bloc) {
    _kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    _kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream: _bloc.calendarDate$,
      builder: (context, snapshot) {
        final selectedDay = snapshot.data ?? DateTime.now();

        return TableCalendar(
          firstDay: _kFirstDay,
          lastDay: _kLastDay,
          focusedDay: selectedDay,
          selectedDayPredicate: (day) => isSameDay(selectedDay, day),
          onDaySelected: (selectedDay, _) => _bloc.selected = selectedDay,
          eventLoader: (day) {
            return _bloc.getEventsForDay(day);
          },
          onFormatChanged: (_) => CalendarFormat.month,
        );
      },
    );
  }
}

class _Details extends StatelessWidget {
  final Stream<Event> stream;

  _Details(this.stream);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder<Event>(
          stream: stream,
          builder: (context, snapshot) {
            if (snapshot.data == null)
              return Column(children: [
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(
                    "Attendance Details",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.black87,
                  height: 2,
                  indent: 12,
                  endIndent: 12,
                ),
                SizedBox(height: 20),
                Text(
                  "No Event",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]);
            else
              return Column(
                children: [
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Attendance Details",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.black87,
                    height: 2,
                    indent: 12,
                    endIndent: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Table(
                      columnWidths: {
                        0: FractionColumnWidth(0.40),
                        1: FractionColumnWidth(0.60),
                      },
                      children: [
                        TableRow(children: [
                          TableCell(
                              child: _TextCell("Attendance Status : ",
                                  bold: true)),
                          TableCell(child: _TextCell("Completed")),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child:
                                  _TextCell("Date Attendance : ", bold: true)),
                          TableCell(child: _TextCell(snapshot.data.title)),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: _TextCell("Start Time : ", bold: true)),
                          TableCell(child: _TextCell("9.00 AM")),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: _TextCell("End Time : ", bold: true)),
                          TableCell(child: _TextCell("4.00 PM")),
                        ]),
                        TableRow(children: [
                          TableCell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(
                                color: Colors.black87,
                                height: 2,
                              ),
                            ),
                          ),
                          TableCell(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Divider(
                                color: Colors.black87,
                                height: 2,
                              ),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: _TextCell("Clock In : ", bold: true)),
                          TableCell(child: _TextCell("9.00 AM")),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: _TextCell("Clock Out : ", bold: true)),
                          TableCell(child: _TextCell("4.00 PM")),
                        ]),
                        TableRow(children: [
                          TableCell(
                              child: _TextCell("Duration : ", bold: true)),
                          TableCell(child: _TextCell("7 Hours")),
                        ]),
                      ],
                    ),
                  ),
                ],
              );
          }),
    );
  }
}

class _TextCell extends StatelessWidget {
  final String value;
  final bool bold;
  final double size;

  _TextCell(this.value, {this.bold = false, this.size: 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Text(
        value,
        style: TextStyle(
            fontWeight: bold ? FontWeight.bold : null, fontSize: size),
      ),
    );
  }
}

class ProgressClock extends StatelessWidget {
  final String clockin;
  final String clockout;
  final String duration;
  final String time;

  const ProgressClock(this.time, this.clockin, this.clockout, this.duration);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: _TextCell("Clocking Session", bold: true, size: 24),
          ),
          Table(
            columnWidths: {
              0: FractionColumnWidth(0.35),
              1: FractionColumnWidth(0.65),
            },
            children: [
              TableRow(children: [
                TableCell(
                    child: _TextCell("Current Time : ", bold: true, size: 16)),
                TableCell(child: _TextCell(time, size: 16)),
              ]),
              TableRow(children: [
                TableCell(
                    child: _TextCell("Clock In : ", bold: true, size: 16)),
                TableCell(child: _TextCell(clockin ?? "", size: 16)),
              ]),
              TableRow(children: [
                TableCell(
                    child: _TextCell("Clock Out : ", bold: true, size: 16)),
                TableCell(child: _TextCell(clockout ?? "", size: 16)),
              ]),
              TableRow(children: [
                TableCell(
                    child: _TextCell("Duration : ", bold: true, size: 16)),
                TableCell(child: _TextCell(duration ?? "", size: 16)),
              ]),
            ],
          ),
          SizedBox(height: 20),
          Divider(
            color: Colors.black87,
            height: 2,
            indent: 12,
            endIndent: 12,
          ),
          SizedBox(height: 12),
          _TextCell("Weekly Completion", bold: true, size: 24),
          SizedBox(height: 12),
          new CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 10.0,
            percent: 0.60,
            center: _TextCell("60%", size: 20),
            progressColor: Colors.green,
          ),
          SizedBox(height: 8),
          _TextCell("Total Work Duration : 36 Hours 25 Minutes", size: 16),
        ],
      ),
    );
  }
}
