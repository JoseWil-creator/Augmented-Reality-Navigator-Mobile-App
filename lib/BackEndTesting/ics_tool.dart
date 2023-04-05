import 'dart:convert';
import 'package:requests/requests.dart';
import '../views/Components/event.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/services.dart' show rootBundle;
import 'package:icalendar_parser/icalendar_parser.dart';

Future<List<Event>> icsToEvent() async {
  List<Event> events = [];
  var r = await Requests.get(
      'https://www.trumba.com/calendars/msudenver-events-calendars.ics');
  r.raiseForStatus();
  String body = r.content();
  body.split('BEGIN:VEVENT');

  return events;
}
