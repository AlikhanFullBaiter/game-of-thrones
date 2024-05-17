import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  static const route = 'calendar';
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    void showSuccessMessage(String error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          error,
        ),
        duration: const Duration(milliseconds: 800),
        showCloseIcon: true,
        closeIconColor: Colors.amber,
        backgroundColor: Colors.green,
      ));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay; // update `_focusedDay` here as well
                });
                ScaffoldMessenger.of(context).clearSnackBars();
                showSuccessMessage(
                    'You picked a ${selectedDay.day}:${selectedDay.month}:${selectedDay.year}');
              },
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            SizedBox(height: 8.0),
            if (_selectedDay != null)
              Text('Selected Day: ${_selectedDay!.toLocal()}'.split(' ')[0]),
          ],
        ),
      ),
    );
  }
}
