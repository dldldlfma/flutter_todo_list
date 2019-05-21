import 'package:flutter/material.dart';
import 'package:todolist1/todo_list/todo_class.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  List<todo_item> items = [todo_item(Icons.check_box, "Hello", "Hi"),];

  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'ToDo List',
      color: Colors.red,
      home: MyPage(items),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  List<todo_item> items;
  MyPage(var items){
    this.items = items;
  }
  MyPageState createState() => new MyPageState(items);
}

class MyPageState extends State<MyPage> {

  List<todo_item> items;
  MyPageState(var items){
    this.items = items;
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  appBar_IconButton_action();
                }),
          ],
        ),
        body: Center(
          child: Todo_list_body(items),
        ),
      floatingActionButton:FloatingActionButton(
        child:Icon(
          Icons.add,
        ),
        backgroundColor: Colors.red,
        onPressed: () {
          print("FAB push");
          setState(() {
            items.add(todo_item(Icons.check_box_outline_blank, "Hello Add","Add by FAB"));
          });

        }
      )
      ,
    );
  }

  void appBar_IconButton_action() {
    setState(() {
      var len = items.length;
      var num =0;
      for(int i=0; i<len;i++){
        if (items[num].todo_icon == Icons.check_box) {
          items.removeAt(num);
        }else{num++;}
      }
    });
  }
}

class Todo_list_body extends StatefulWidget {
  List<todo_item> items;
  Todo_list_body(var items){
    this.items = items;
  }
  Todo_body createState() => Todo_body(items);
}

class Todo_body extends State<Todo_list_body> {
  List<todo_item> item = [];
  Todo_body(var items) {
    this.item = items;
  }


  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          return ListTile(
            //leading : Add image icon
            leading: Icon(item[index].todo_icon),
            title: Text('${item[index]}'),
            subtitle: Text(item[index].todo_sub),
            onTap: () {
              setState(() {
                if (item[index].todo_icon == Icons.check_box_outline_blank) {
                  item[index].todo_icon = Icons.check_box;
                } else {
                  item[index].todo_icon = Icons.check_box_outline_blank;
                }
              });
            },
            onLongPress: () {},
          );
        });
  }
}



