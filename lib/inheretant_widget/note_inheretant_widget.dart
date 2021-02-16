import 'package:flutter/cupertino.dart';


class NoteInheritedWidget extends InheritedWidget{

  final notes=[
    {
      'Title':'A',
      'Text':'abc'
    },
    {
      'Title':'B',
      'Text':'bdffdfs'
    },
    {
      'Title':'C',
      'Text':'lskfkdogikpdgikgkpxfkg'
    },
  ];

  NoteInheritedWidget(Widget child):super(child:child);


  static NoteInheritedWidget of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(NoteInheritedWidget) as NoteInheritedWidget);
  }
  @override
  bool updateShouldNotify(NoteInheritedWidget  oldWidget) {
   return oldWidget.notes !=notes;
    //return true;
  }
  
}