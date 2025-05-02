import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/task_list_page.dart';

class TaskInfo extends StatelessWidget{

  late final Map<String,dynamic> task;
  
  TaskInfo(Map<String,dynamic> t){
    task=t;
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                    Text("Title : ",style: TextStyle(
                      fontSize: 35,
                      fontFamily: "LeagueGothic",color:Color(0xFF5C7285)
                    ),),
                    Text(" ${task['title']}",style: TextStyle(
                      fontSize: 25,
                    ),),
                Text("Description :",style: TextStyle(
                  fontSize: 35,
                  fontFamily: "LeagueGothic",
                    color:Color(0xFF5C7285)
                ),),
                Text("${task['description']}",style: TextStyle(
                  fontSize: 15
                ),),
                Text("Deadline : ",style: TextStyle(
                    fontSize: 35,
                    fontFamily: "LeagueGothic",
                    color:Color(0xFF5C7285)
                ),),
                Text("${task['dateTime']}",style: TextStyle(
                  fontSize: 15
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }

}