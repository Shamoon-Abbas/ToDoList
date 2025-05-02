import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/main.dart';
import 'package:to_do_list/to_do_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/material/scaffold.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskPageState();
  }
}

class AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? datePicked;
  TimeOfDay? timePicked;
  DateTime? time;
  String? formattedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Add Task"),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  height: 70,
                  width: 350,
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                        label: Text(
                          'Title',
                          style: TextStyle(
                            color: Color(0xFF5C7285),
                            fontSize: 20,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Color(0xFF5C7285)),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF818C78), width: 2))),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: 350,
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                        label: Text(
                          'Description',
                          style: TextStyle(
                            color: Color(0xFF5C7285),
                            fontSize: 20,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Color(0xFF5C7285),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide(
                                color: Color(0xFF818C78), width: 2))),
                    maxLines: 12,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 35, top: 10, right: 5, bottom: 20),
                      child: ElevatedButton(
                        onPressed: () async {
                          datePicked = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(3000));

                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF5C7285),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.date_range),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "Date",
                              style: TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 0.0, 20),
                      child: ElevatedButton(
                          onPressed: () async {
                            timePicked = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input);
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF5C7285),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              elevation: 5.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.access_time),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Time",
                                style: TextStyle(fontSize: 17),
                              )
                            ],
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Center(
                  child: Container(
                    width: 250,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          final title = titleController.text.trim();
                          final description = descriptionController.text.trim();

                          if (datePicked != null && timePicked != null) {
                            time = combineDateAndTime(datePicked!, timePicked!);
                            formattedDate =
                                DateFormat('yyyy-MM-dd hh:mm a').format(time!);
                          } else if (title.isNotEmpty &&
                              description.isNotEmpty) {
                            //Remove any existing SnackBar
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Please select the Date & Time"),
                              duration: Duration(seconds: 2),
                            ));
                          }

                          if (title.isNotEmpty &&
                              description.isNotEmpty &&
                              time != null) {
                            context.read<ToDoProvider>().addTask({
                              'title': title,
                              'description': description,
                              'dateTime': formattedDate,
                              'completed': false
                            });
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Task added successfully"),
                              duration: Duration(seconds: 2),
                            ));
                          } else {
                            //Remove any existing SnackBar
                            ScaffoldMessenger.of(context)
                                .removeCurrentSnackBar();

                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Please fill out all the blanks'),
                                duration: Duration(seconds: 2)));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF818C78),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5.0),
                        child: Text('Add Task')),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}
