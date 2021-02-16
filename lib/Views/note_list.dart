import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Providers/note_provider.dart';
import 'package:flutter_app/inheretant_widget/note_inheretant_widget.dart';
import 'note.dart';
class NoteList extends StatefulWidget{
  @override
  _NoteListState createState()
  => _NoteListState();
}

class _NoteListState extends State<NoteList> {
 // List<Map<String,String>> get notes => NoteInheritedWidget.of(context).notes;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: new AppBar(
        title: Text("Notes"),
        backgroundColor: Colors.purple,
      ),
        body:FutureBuilder(
          future: NoteProvider.getNoteList(),
          builder:(context,snapshot) {
            if(snapshot.connectionState==ConnectionState.done) {
              final notes=snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                          Note(NoteMode.Editing, notes[index])),
                      );
                      setState(() {});
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30, bottom: 30, left: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            NoteTitle(notes[index]['title']),
                            Container(height: 6,),
                            NoteText(notes[index]['text']),
                          ]
                          ,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: notes.length,
              );
            }
            return Center(
              child: CircularProgressIndicator()
            );
          },
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()   async {
         await Navigator.push(
            context, MaterialPageRoute(builder: (context) =>Note(NoteMode.Adding,null) ),
          );
         setState(() {});
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }
}


class NoteTitle extends StatelessWidget{
  final String title;
  NoteTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return  Text(
        title,
        style:TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.purple,
        )
    );
  }


}


class NoteText extends StatelessWidget{
  final String text;
  NoteText(this.text);
  @override
  Widget build(BuildContext context) {
   return Text(
     text
     ,
     style: TextStyle(
         color: Colors.grey,
         fontSize: 18
     ),
     maxLines: 3,
     overflow: TextOverflow.ellipsis,

   );
  }

}