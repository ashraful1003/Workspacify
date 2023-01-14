import 'package:flutter/material.dart';

class WeekView extends StatelessWidget {
  List<String> week;

  WeekView({Key? key, required this.week}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: week.length,
          itemBuilder: (context, index) {
            return SizedBox(
                width: MediaQuery.of(context).size.width / week.length,
                child: Text(week[index],
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black)));
          }),
    );
  }
}
