import 'package:customheader/repository/data_source.dart';
import 'package:customheader/screens/home/day_view.dart';
import 'package:customheader/screens/home/header_view.dart';
import 'package:customheader/screens/home/week_view.dart';
import 'package:customheader/widgets/appointments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

void main() => runApp(const CustomHeaders());

class CustomHeaders extends StatelessWidget {
  const CustomHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => ScheduleExample();
}

class ScheduleExample extends State<MyApp> {
  final CalendarController _controller = CalendarController();
  String? _headerText, date;
  String view = "3", viewer = "3", weekName = '';
  List<String> weekDay = [], week = [];
  bool enable = true;

  double scaleFactor = 1.0, baseFactor = 1.0;
  int k = 0;

  @override
  void initState() {
    _headerText = '';
    weekDay.add("");
    week.add("");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: GestureDetector(
        onScaleStart: (details) {
          setState(() {
            scaleFactor = baseFactor;
            enable = true;
          });
        },
        onScaleUpdate: (details) {
          if (enable) {
            setState(() {
              scaleFactor = details.scale;
            });
          }
        },
        onScaleEnd: (details) {
          setState(() {
            if (enable) {
              if (baseFactor < scaleFactor) {
                k = 1;
              }
              if (baseFactor > scaleFactor) {
                k = -1;
              }
            }
            print("$k        kkk");
            enable = false;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// customize appbar
            HeaderView(headerText: _headerText),

            /// show the weeks name
            viewer != "0"
                ? WeekView(week: week)
                : Row(
                    children: [
                      Spacer(flex: 1),
                      Container(height: 30, child: Text(weekName)),
                      Spacer(flex: 6)
                    ],
                  ),

            /// show the date of the month
            if (viewer == "1") DayView(weekDay: weekDay),

            /// calender view
            Expanded(
                child: SfCalendar(
              headerHeight: 0,
              viewHeaderHeight: 0,
              todayHighlightColor: Colors.black,
              controller: _controller,
              view: findController(),

              dataSource: DataSource(getAppointments()),

              /// month view becomes appointment view so that events
              /// can be shown as box
              monthViewSettings: const MonthViewSettings(
                  appointmentDisplayMode:
                      MonthAppointmentDisplayMode.appointment),

              /// update the week name and date
              onViewChanged: (ViewChangedDetails viewChangedDetails) {
                view = _controller.view!.index.toString();
                viewer = _controller.view!.index.toString();
                k = 0;

                /// if the calender mode is month
                if (_controller.view == CalendarView.month) {
                  _headerText = DateFormat('MMMM')
                      .format(viewChangedDetails.visibleDates[
                          viewChangedDetails.visibleDates.length ~/ 2])
                      .toString();

                  week.clear();
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[0])
                      .toString());
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[1])
                      .toString());
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[2])
                      .toString());
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[3])
                      .toString());
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[4])
                      .toString());
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[5])
                      .toString());
                  week.add(DateFormat('E')
                      .format(viewChangedDetails.visibleDates[6])
                      .toString());
                }

                /// if the calender mode is week
                if (_controller.view == CalendarView.week) {
                  _headerText = DateFormat('MMMM')
                      .format(viewChangedDetails.visibleDates[
                          viewChangedDetails.visibleDates.length ~/ 2])
                      .toString();

                  week.clear();
                  week.add("");
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[0])
                      .toString());
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[1])
                      .toString());
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[2])
                      .toString());
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[3])
                      .toString());
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[4])
                      .toString());
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[5])
                      .toString());
                  week.add(DateFormat('EEE')
                      .format(viewChangedDetails.visibleDates[6])
                      .toString());

                  weekDay.clear();
                  weekDay.add("");
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[0])
                      .toString());
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[1])
                      .toString());
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[2])
                      .toString());
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[3])
                      .toString());
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[4])
                      .toString());
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[5])
                      .toString());
                  weekDay.add(DateFormat('dd')
                      .format(viewChangedDetails.visibleDates[6])
                      .toString());

                  _headerText = "$_headerText ${weekDay[1]}-${weekDay[7]}";

                  SchedulerBinding.instance.addPostFrameCallback((duration) {
                    setState(() {});
                  });
                }

                /// if the calender mode is day
                if (_controller.view == CalendarView.day) {
                  week.clear();
                  weekDay.clear();
                  _headerText = DateFormat('MMMM DD, yyyy')
                      .format(viewChangedDetails.visibleDates[
                          viewChangedDetails.visibleDates.length ~/ 2])
                      .toString();

                  weekName = DateFormat('EEEE')
                      .format(viewChangedDetails.visibleDates[
                          viewChangedDetails.visibleDates.length ~/ 2])
                      .toString();
                }
              },
            )),
          ],
        ),
      ),
    ));
  }

  findController() {
    k == 0 && view == "3"
        ? _controller.view = CalendarView.month
        : k == 1 && view == "3"
            ? _controller.view = CalendarView.week
            : k == 1 && view == "1"
                ? _controller.view = CalendarView.day
                : k == -1 && view == "1"
                    ? _controller.view = CalendarView.month
                    : k == -1 && view == "0"
                        ? _controller.view = CalendarView.week
                        : _controller.view;

    print(_controller.view);
    return _controller.view;
  }
}
