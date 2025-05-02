import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/splash_screen.dart';
import 'package:to_do_list/task_list_page.dart';
import 'package:to_do_list/to_do_provider.dart';

void main(){
  runApp(ChangeNotifierProvider(create: (context)=>ToDoProvider(),
    child:  MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "To-Do List",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFE2E0C8)
      ),
      home: SplashScreen(),
    );
  }
}


class homeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return homeScreenState();
  }
}

class homeScreenState extends State<homeScreen>{

  int _selectedIndex=0;

  final List<Widget> _pages=[
    TaskListPage(filter: 'all'),
    TaskListPage(filter: 'completed'),
    TaskListPage(filter: 'uncompleted'),
    TaskListPage(filter: 'past'),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:_pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          showUnselectedLabels: true,
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Color(0xFF5C7285),
          unselectedItemColor: Color(0xFFA7B49E),
          selectedLabelStyle: TextStyle(
            fontWeight: FontWeight.bold
          ),


          currentIndex: _selectedIndex,
          onTap: (index){
            setState(() {
              _selectedIndex=index;
            });
          },
          items:[
            BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label:"All Tasks"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label:"Completed"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.incomplete_circle),
                label:"Uncompleted"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.history),
                label: "Past Tasks"
            )
          ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

}