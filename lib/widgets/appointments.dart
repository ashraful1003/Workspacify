import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

List<Appointment> getAppointments() {
  List<Appointment> meetings = <Appointment>[];
  DateTime today = DateTime.now();
  DateTime start = DateTime(today.year, today.month, today.day, 6, 0, 0);
  DateTime end = start.add(const Duration(hours: 1));
  meetings.add(
    Appointment(
      startTime: start,
      endTime: end,
      subject: "Birthday Party",
      color: Colors.blue,
    ),
  );
  return meetings;
}
