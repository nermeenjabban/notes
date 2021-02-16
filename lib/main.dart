import 'package:flutter/material.dart';
import 'Views/note_list.dart';
import 'inheretant_widget/note_inheretant_widget.dart';

void main() {
  runApp(App());
}
class App extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return NoteInheritedWidget(
    MaterialApp(
      title:"Notes App",
      home:NoteList(),
    ),
  );
  }
  }



