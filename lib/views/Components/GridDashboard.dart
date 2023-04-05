import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unitrail/views/Components/event_editing.dart';
import 'package:unitrail/views/Widgets/calendar_widget.dart';
import 'package:unitrail/views/Widgets/costumed_home_button.dart';
import 'package:unitrail/views/classes.dart';
import 'package:unitrail/views/navigate.dart';
import 'package:unitrail/views/settings.dart';

import 'package:unitrail/models/schedule.dart';
import "package:url_launcher/url_launcher.dart";
//import 'package:universal_html/html.dart';
//import 'package:flutter/foundation.dart';

// ignore: must_be_immutable
class GridDashboard extends StatelessWidget {
  final List<Schedule> schedule;
  GridDashboard({
    required this.schedule,
  });
  void openLink() async {
    var url = Uri.parse('https://www.google.com/');
    if(await canLaunchUrl(url)){
      await launchUrl(url, 
      );
    } else {
      throw 'Could not lauch $url';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: GridView.count(
      childAspectRatio: 0.65,
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 40),
      crossAxisCount: 2,
      crossAxisSpacing: 18,
      mainAxisSpacing: 18,
      children: <Widget>[
       // Text("Hello"),
        CustomButton(
            buttonTitle: 'Navigate',
            buttonColor: Colors.blue,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NavigateScreen();
              }));
            },
            picPath: 'assets/images/ar-maps.jpg'),
        CustomButton(
            buttonTitle: 'Classes',
            buttonColor: Colors.deepPurple,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ClassSchedule(
                  classes: schedule,
                );
              }));
            },
        picPath: 'assets/images/school.jpg'),
        CustomButton(
            buttonTitle: 'Calendar',
            buttonColor: Colors.red,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => 
                Scaffold (
                  appBar: AppBar(
                    title: Text('Calendar Events'),
                    centerTitle: true,
                  ),
                  body: CalendarWidget(),
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => EventEditingPage()),),
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                )
                ));
            },
            picPath: 'assets/images/calendar.png'),
        CustomButton(
            buttonTitle: 'Organization',
            buttonColor: Colors.red,
            onPressed: openLink,
            picPath: 'assets/images/aesBuilding.jpg'),
        // CustomButton(
        //     buttonTitle: 'Classes',
        //     buttonColor: Colors.deepPurple,
        //     onPressed: null,
        //     picPath: 'assets/images/c.jpg')
      ],
    ));
  }
}

class Items {
  String title;
  // ignore: prefer_typing_uninitialized_variables
  final routeName;
  Items({required this.title, required this.routeName});
}
