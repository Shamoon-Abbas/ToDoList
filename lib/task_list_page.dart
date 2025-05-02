import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/task_info.dart';
import 'package:to_do_list/to_do_provider.dart';


import 'add_task_page.dart';

class TaskListPage extends StatelessWidget {

  late final String filter;
  TaskListPage({required this.filter});

  @override
  Widget build(BuildContext context) {


    final provider = Provider.of<ToDoProvider>(context);
    List<Map<String,dynamic>> tasks=[];

    if(filter=='all'){
      tasks=provider.allTasks();
    }else if(filter=='completed'){
      tasks=provider.completedTasks();
    }else if(filter=='uncompleted'){
      tasks=provider.uncompletedTasks();
    }else if(filter=='past'){
      tasks=provider.pastTasks();
    }





    return Scaffold(
      appBar: AppBar(
        title: Text("${filter[0].toUpperCase()}${filter.substring(1)} Tasks"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: tasks.isNotEmpty?

      ListView.builder(

        itemCount: tasks.length,

        itemBuilder: (context,index){
              final task=tasks[index];

              // String time=DateFormat('hh:mm a').format(task['dateTime']);
              // String date=DateFormat('dd-MM-yyyy').format(task['dateTime']);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListTile(shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(200),
                  borderSide: BorderSide( )
                ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 8.0),
                  title: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=>TaskInfo(task)));
                    },
                    child: Text(task['title'],style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                  subtitle:
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=>TaskInfo(task)));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${task['description']}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                fontSize:10
                              ),
                              ),
                              Text("\nDeadline: ${task['dateTime']}",style: TextStyle(
                                fontSize: 12
                              ),)
                            ],
                          ),
                        ),
                      ),

                  leading: Column(
                    children: [
                      Checkbox(
                          value: task['completed'],
                          onChanged: (value) {
                            provider.toggleTask(provider.getTasks.indexOf(task));
                          },
                      ),
                      Text("Complete",style: TextStyle(fontSize: 5,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if(!(filter=='past'))
                        IconButton(onPressed: (){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                final TextEditingController titleController=TextEditingController();
                                final TextEditingController descriptionController=TextEditingController();

                                // int realIndex=0;
                                // List<Map<String,dynamic>> completeList=context.read<ToDoProvider>().getTasks;
                                //
                                // for(int i=0;i<completeList.length;i++) {
                                //   if (tasks[index] == completeList[i]) {
                                //     realIndex = i;
                                //   }
                                // }


                                // final currentTask=context.read<ToDoProvider>().getTasks[realIndex];
                                final currentTask=tasks[index];

                                // Pre-fill the text fields with the current task's data
                                titleController.text=currentTask['title'];
                                descriptionController.text=currentTask['description'];

                                return AlertDialog(

                                  title: const Text("Edit Task"),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: titleController,
                                        decoration: InputDecoration(label: const Text('Title',style: TextStyle(
                                          color: Color(0xFF5C7285),
                                          fontWeight: FontWeight.bold
                                        ),),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Color(0xFF818C78),
                                            )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Color(0xFF818C78),
                                              width: 2
                                            )
                                          )
                                        ),
                                      ),
                                      SizedBox(height: 20,),
                                      TextField(
                                        controller: descriptionController,
                                          decoration: InputDecoration(label: const Text('Description',style: TextStyle(
                                            color: Color(0xFF5C7285),
                                            fontWeight: FontWeight.bold
                                          ),),enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Color(0xFF818C78),
                                            )
                                          ),focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: Color(0xFF818C78),
                                              width: 2
                                            )
                                          )
                                          ),
                                      maxLines: 5,),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(onPressed: (){
                                      Navigator.of(context).pop();
                                    }, child: const Text("Cancel",style: TextStyle(
                                      color: Color(0xFF5C7285)
                                    ),),
                                    ),
                                    ElevatedButton(onPressed: (){
                                      // Update the task in the provider
                                      context.read<ToDoProvider>().updateTask(
                                        {
                                          'title': titleController.text,
                                          'description': descriptionController.text,
                                          'dateTime': currentTask['dateTime'], // Keep the original dateTime
                                          'completed': currentTask['completed'], // Keep the original completion status
                                        },
                                        index,filter
                                      );
                                      Navigator.of(context).pop();// Close the dialog after updating

                                    }, child: const Text('Save',style: TextStyle(
                                      color: Colors.white
                                    ),
                                    ),style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF5C7285)
                                    ),
                                ),
                                ],
                                );

                              });

                        }, icon: Icon(Icons.edit,size: 20,),),
                        IconButton(onPressed: (){

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Deletion'),
                        content: const Text('Are you sure you want to proceed?'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog without confirming
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () {

                              int realIndex=-1;
                              List<Map<String,dynamic>> completeList=context.read<ToDoProvider>().getTasks;

                              for(int i=0;i<completeList.length;i++) {
                                if (tasks[index] == completeList[i]) {
                                  realIndex = i;
                                }
                              }

                              // Perform action on "Yes" selection
                               context.read<ToDoProvider>().removeTask(realIndex);
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    },
                  );

                  // context.read<ToDoProvider>().removeTask(index);

                        }, icon: Icon(Icons.delete,size: 20,))
                      ],
                    ),
                  ),

                ),
              );

            },

          ): Center(child: Text("No Tasks to display yet"),

      ),
      floatingActionButton: filter=='all'?
      FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(
          builder:(context)=>AddTaskPage(),
        ),
        );
      },backgroundColor: Color(0xFF5C7285),
        foregroundColor: Colors.white,

        child: Icon(Icons.add),) : null,

    );
  }
}