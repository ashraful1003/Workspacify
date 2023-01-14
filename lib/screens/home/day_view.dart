import 'package:flutter/material.dart';

class DayView extends StatelessWidget {
  List<String> weekDay;

  DayView({Key? key, required this.weekDay}) : super(key: key);

  DateTime todayTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: weekDay.length,
          itemBuilder: (context, index) {
            return Container(
                width: MediaQuery.of(context).size.width / 8,
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: todayTime.day.toString() == weekDay[index]
                        ? Colors.black
                        : Colors.white,
                  ),
                  child: Text(weekDay[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: todayTime.day.toString() == weekDay[index]
                              ? Colors.white
                              : Colors.black)),
                ));
          }),
    );
  }
}
