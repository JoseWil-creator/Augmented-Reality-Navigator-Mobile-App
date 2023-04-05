import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:unitrail/views/Components/event_data_source.dart';
import 'package:unitrail/views/Provider/event_provider.dart';
import 'package:unitrail/views/Widgets/tasks_widget.dart';

class CalendarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;

    return Container(
      child: SfCalendar(
        view: CalendarView.month,
        dataSource: EventDataSource(events),
        showNavigationArrow: true,
        initialSelectedDate: DateTime.now(),
        cellBorderColor: Colors.transparent,
        onLongPress: (details) {
          final provider = Provider.of<EventProvider>(context, listen: false);

          provider.setDate(details.date!);
          showModalBottomSheet(
            context: context, 
            builder: (context) => TasksWidget(),
          );
        },
      ),
    );
  }
}
