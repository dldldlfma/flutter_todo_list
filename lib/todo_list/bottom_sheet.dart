import 'package:flutter/material.dart';
import 'package:todolist1/todo_list/todo_class.dart';
import 'package:intl/intl.dart';

class bottom_sheet{
  //take text value using this text_controller
  TextEditingController text_controller = TextEditingController();

  List<todo_item> items;
  bottom_sheet(var items){
    this.items = items;
  }

  mainBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: <Widget>[
            Container(
                child: Center(
                  child: Text(
                    "Make To do Content",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                )),
            TextFormField(
              controller: text_controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'what are you have to do?\n\n',
              ),
              maxLines: 3,
              autofocus: true,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (text) {
                print(text_controller.text);
                String now = DateFormat('yyyy-MM-dd - kk:mm').format(DateTime.now());
                items.add(todo_item(Icons.check_box_outline_blank, text_controller.text, now));
              },
            )
          ],
        );
      },
    );
  }
}



