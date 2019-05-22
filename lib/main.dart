import 'package:flutter/material.dart';
import 'package:todolist1/todo_list/todo_class.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'dart:async';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'package:intl/intl.dart';

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
                  //Delete check value
                  appBar_IconButton_action();
                }),
          ],
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Container(
                height:440,
                child:Todo_list_body(items),
              ),
            ]
          )
        ),
        floatingActionButton:FloatingActionButton(
            child:Icon(
              Icons.add,
            ),
        backgroundColor: Colors.red,

        onPressed: () => _onFABbutton(),
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

  void _onFABbutton() {

    TextEditingController text_controller = TextEditingController();

    showModalBottomSheet(context: context, builder: (context) {
      return Column(
          children: <Widget>[
            TextFormField(
              controller: text_controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'what are you have to do?\n\n'),
              maxLines: 3,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (text) => _onFieldSubmitted(text_controller),
            )
            ]);
    });
  }

  void _onFieldSubmitted(var text_controller){
    Navigator.pop(context);
    setState(() {String now = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
    items.add(todo_item(
        Icons.check_box_outline_blank, text_controller.text, now));}
        );
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
        scrollDirection: Axis.vertical,
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
