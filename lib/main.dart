import 'package:flutter/material.dart';
import 'package:todolist1/todo_list/todo_class.dart';
import 'package:todolist1/todo_list/bottom_sheet.dart';

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
    bottom_sheet modal = bottom_sheet(items);

    return Scaffold(
        appBar: AppBar(
          title: Text('ToDo List'),
          backgroundColor: Colors.red,
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  //Delete check value
                  appBar_IconButton_action();
                }),
          ],
        ),
        body: Todo_list_body(items),
        floatingActionButton:FloatingActionButton(
            child:Icon(
              Icons.add,
            ),
        backgroundColor: Colors.red,

        onPressed: () {
          setState(() {
            modal.mainBottomSheet(context);
            setState((){print("FAB push");});
          });

        }
      ),
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
            leading: Icon(item[index].todo_icon),
            title: Text(item[index].todo_title),
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


class botsheet extends StatefulWidget {
  @override
  _botsheetState createState() => _botsheetState();
}

class _botsheetState extends State<botsheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text("Hello"),
    );
  }
}
