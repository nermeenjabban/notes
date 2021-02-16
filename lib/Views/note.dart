import 'package:flutter/material.dart';
import 'package:flutter_app/Providers/note_provider.dart';
import 'package:flutter_app/inheretant_widget/note_inheretant_widget.dart';
enum NoteMode{
  Adding,Editing
}

class Note extends StatefulWidget{
  NoteMode noteMode;
  final Map<String,dynamic> note;
  //final int index;
  Note(this.noteMode,this.note);
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  final TextEditingController titleController=TextEditingController();
  final TextEditingController textController=TextEditingController();
  List<Map<String,String>> get notes => NoteInheritedWidget.of(context).notes;
  @override
  void didChangeDependencies() {
    if(widget.noteMode==NoteMode.Editing){
      titleController.text=widget.note['title'];
      textController.text=widget.note['text'];
    }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text( widget.noteMode == NoteMode.Adding ? "Add note" : "Edit note"
        ),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
            children: <Widget>[
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
              )
            ),
              Container(height: 6,),
            TextField(
                controller: textController,
                decoration: InputDecoration(
                    hintText: "Text"
                )
            ),
                 Container(height: 18,),
                    Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      NoteButton("Save",Colors.purple,(){
                        final title=titleController.text;
                        final text=textController.text;
                        if(widget.noteMode==NoteMode.Adding ){
                          NoteProvider.insertNote({
                            "title": title,
                            "text": text
                          }
                          );

                        }
                        else if(widget.noteMode==NoteMode.Editing) {
                          NoteProvider.updateNote({
                            "id": widget.note["id"],
                            "title": titleController.text,
                            "text": textController.text
                          });
                        }
                        Navigator.pop(context);
                        }),
                     Container(height: 16.0,),
                      NoteButton("Discard",Colors.purple,(){Navigator.pop(context);}),
                      Container(height: 16.0,),
                       widget.noteMode == NoteMode.Editing?
                        NoteButton("Delete",Colors.purple,() async{
                         // notes.removeAt(widget.index);
                          await NoteProvider.deleteNote(widget.note['id']);
                          Navigator.pop(context);})
                         :Container(),
                    ],
                ),
          ],
          ),
      ),
    );
  }
}

class NoteButton extends StatelessWidget{
  String text;
  Color color;
  Function onPressed;
  NoteButton(this.text, this.color, this.onPressed);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   MaterialButton(onPressed:onPressed,
      child:Text(text,
        style: TextStyle(color:Colors.white),
      ),
      color:color,
      minWidth:80,
    ) ;
  }
}