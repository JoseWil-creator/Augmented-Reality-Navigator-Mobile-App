import 'package:flutter/material.dart';
import 'package:unitrail/models/schedule.dart';
import 'package:unitrail/views/Widgets/back_button.dart';
import 'package:unitrail/views/Widgets/custom_appbar.dart';
import 'package:unitrail/views/Widgets/schedule_box.dart';
import 'package:unitrail/views/Widgets/windows_appbar.dart';

class ClassSchedule extends StatefulWidget {
  final List<Schedule> classes;

  ClassSchedule({
    required this.classes,
  });
  @override
  State<ClassSchedule> createState() => _ClassScheduleState();
}

class _ClassScheduleState extends State<ClassSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WindowsAppBar(),
        body: ListView.builder(
          itemCount: widget.classes.length,
          itemBuilder: (context, index) {
            return DecoratedBox(
              
              decoration: BoxDecoration(
                gradient: LinearGradient(
                colors: [Color(0xFFFACCCC), Color(0xFFF6EFE9)],),
                
              ),
          
              child: Column(
                children: [
                  ScheduleBox(
                    crn: widget.classes[index].crn, 
                    name: widget.classes[index].name, 
                    time: widget.classes[index].time, 
                    onPressed: null, 
                    day: widget.classes[index].day, 
                    location: widget.classes[index].location, 
                    description: widget.classes[index].description,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
