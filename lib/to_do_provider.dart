import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoProvider extends ChangeNotifier {
  List<Map<String, dynamic>> _tasks = [];

  List<Map<String, dynamic>> get getTasks => _tasks;

  ToDoProvider() {
    _loadTasks(); // Load tasks when the provider is initialized
  }

  void addTask(Map<String, dynamic> task) {
    // Ensure the dateTime field is properly formatted before adding
    final dateTimeString = task['dateTime'];
    if (dateTimeString != null) {
      final DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');
      //dateFormat.parse(dateTimeString) //parse(convert) the String to dateTime
      //the following method takes dateTime and returns the String in specified format
      task['dateTime'] = dateFormat.format(dateFormat.parse(dateTimeString));
    }

    _tasks.add(task);
    _saveTasks();
    notifyListeners();
  }

  void updateTask(Map<String, dynamic> updatedTask, int index,String filter) {

    List<Map<String,dynamic>> checkList=[];
    int actualIndex=0;

    if(filter=='completed'){
      checkList = completedTasks();
    }else if(filter=='uncompleted'){
      checkList = uncompletedTasks();
    }else if(filter=='past'){
      checkList = pastTasks();
    }else{
      checkList = allTasks();
    }

    for(int i=0;i<_tasks.length;i++){
      if(_tasks[i]==checkList[index]){
        actualIndex=i;
      }
    }


    // final dateTimeString = updatedTask['dateTime'];
    // if (dateTimeString != null) {
    //   final DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');
    //   updatedTask['dateTime'] = dateFormat.format(dateFormat.parse(dateTimeString));
    // }

    _tasks[actualIndex] = updatedTask;
    _saveTasks();
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasks[index]['completed'] = !_tasks[index]['completed'];
    _saveTasks();
    notifyListeners();
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    _saveTasks();
    notifyListeners();
  }

  List<Map<String, dynamic>> allTasks() => getTasks;

  List<Map<String, dynamic>> completedTasks() =>
      _tasks.where((getTasks) => getTasks['completed']).toList();

  List<Map<String, dynamic>> uncompletedTasks() =>
      _tasks.where((getTasks) => !getTasks['completed']).toList();

  List<Map<String, dynamic>> pastTasks() {
    return _tasks.where((getTasks) {
      // Ensure the dateTime exists
      final dateTimeString = getTasks['dateTime'];
      if (dateTimeString == null) return false;

      try {
        // Define the date format based on the provided string
        final DateFormat dateFormat = DateFormat('yyyy-MM-dd hh:mm a');

        // Parse the date using the custom format
        //the following line returns the dateTime
        final taskDateTime = dateFormat.parse(dateTimeString);

        // Compare the parsed DateTime with the current DateTime
        return taskDateTime.isBefore(DateTime.now());
      } catch (e) {
        // Log any errors in parsing
        print('Error parsing dateTime: $e');
        print(dateTimeString); // Print the problematic date string for debugging
        return false;
      }
    }).toList();
  }

  Future<void> _saveTasks() async {
    //prefs is of SharedPreferences type
    final prefs = await SharedPreferences.getInstance();
    //tasksJson is of String type containing JSON data
    final tasksJson = jsonEncode(_tasks);
    print("Saving tasks: $tasksJson");
    await prefs.setString('tasks', tasksJson);
  }

  Future<void> _loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString('tasks');
    print("Loaded tasks: $tasksJson");
    if (tasksJson != null) {
      _tasks = List<Map<String, dynamic>>.from(jsonDecode(tasksJson));
      notifyListeners();
    }
  }
}
