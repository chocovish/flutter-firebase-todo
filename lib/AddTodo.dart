import 'package:flutter/material.dart';
import './Home.dart';

class AddToDo extends StatefulWidget {

  @override
  _AddToDoState createState() => _AddToDoState();
}

class _AddToDoState extends State<AddToDo> {
  DateTime newdate;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 200,
      shape: OutlineInputBorder(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
              controller: tc,
              decoration: InputDecoration(
          suffix: timeSetter(context),
          border: OutlineInputBorder(),
          fillColor: Colors.cyan[50],
          filled: true,
          hintText: "Add TooDoo"),
              onSubmitted: (s) {
                if (s.isNotEmpty) {
          fi
              .collection("todos")
              .document()
              .setData({"task": s, "completed": false,"email":email});
          tc.clear();
          Navigator.pop(context);
                }
              },
            ),
          Text(newdate.toString())
        ],
      ),
    );
  }

  InkWell timeSetter(BuildContext context) {
    return InkWell(
      child: Icon(Icons.calendar_today),
      onTap: () async {
        selectedDate = await showDatePicker(
            firstDate: DateTime.now(),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100),
            context: context);
        // select Time
        selectedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        print(selectedDate.toUtc());
        print(selectedTime);
        setState(() {
          newdate = DateTime(selectedDate.year,selectedDate.month,selectedDate.day,selectedTime.hour,selectedTime.minute);
        });
      },
    );
  }
}
