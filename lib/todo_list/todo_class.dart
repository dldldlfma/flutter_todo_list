import 'package:flutter/material.dart';

class todo_item {
  var todo_icon;
  var todo_title;
  var todo_sub;

  void init_value(IconData icon, var title, var sub) {
    this.todo_icon = icon;
    this.todo_title = title;
    this.todo_sub = sub;
  }

  todo_item(IconData icon, var title, var sub) {
    init_value(icon, title, sub);
  }
}