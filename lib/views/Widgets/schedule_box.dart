import 'dart:ui';

import 'package:flutter/material.dart';

class ScheduleBox extends StatelessWidget {
  final String crn;
  final String name;
  final String time;
  final String day;
  final String location;
  final String description;
  final void Function()? onPressed;
  //final Icons icon;

  ScheduleBox({
    required this.crn,
    required this.name,
    required this.time,
    required this.onPressed,
    required this.day,
    required this.location,
    required this.description,
   /// required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
           Icon(Icons.school,
                      size: 25, 
                      color: Colors.red
                ),
            TextButton.icon(
              label: Text("CRN: " + crn),
              icon: Icon(Icons.numbers),
              onPressed: null, 
              ),
              TextButton.icon(
              label: Text("Name: " + name),
              icon: Icon(Icons.person),
              onPressed: null, 
              ),
              TextButton.icon(
              label: Text("Time: " + time),
              icon: Icon(Icons.punch_clock),
              onPressed: null, 
              ),
              TextButton.icon(
              label: Text("Day: " + day),
              icon: Icon(Icons.date_range),
              onPressed: null, 
              ),
              TextButton.icon(
              label: Text("location: " + location),
              icon: Icon(Icons.location_city),
              onPressed: null, 
              ),
              TextButton.icon(
              label: Text("Description: " + description),
              icon: Icon(Icons.book),
              onPressed: null, 
              
              ),
        ]
      ),
    );
  }
}