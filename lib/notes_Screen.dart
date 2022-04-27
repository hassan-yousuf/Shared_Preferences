import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes extends StatefulWidget {
  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  SharedPreferences? sharedPreferences;

  List<String>? notesTitleList = [];
  List<String>? notesList = [];

  List<String>? favnotesTitleList = [];
  List<String>? favnotesList = [];

  getNotes() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? getNotesTitleList =
        sharedPreferences?.getStringList('notesTitleList');
    notesTitleList = getNotesTitleList!.map((e) => e.toString()).toList();
    setState(() {});

    List<String>? getNotesList = sharedPreferences?.getStringList('notesList');
    notesList = getNotesList!.map((e) => e.toString()).toList();
    setState(() {});
  }

  getFavNotes() async {
    sharedPreferences = await SharedPreferences.getInstance();
    List<String>? getFavNotesTitleList =
        sharedPreferences?.getStringList('FavNotesTitleList');
    favnotesTitleList = getFavNotesTitleList!.map((e) => e.toString()).toList();
    setState(() {});

    List<String>? getFavNotesList =
        sharedPreferences?.getStringList('FavNotesDescriptList');
    favnotesList = getFavNotesList!.map((e) => e.toString()).toList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getNotes();
    getFavNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("My Notes"),
      ),
      floatingActionButton: favnotesList!.length >= 1
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton.extended(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/fav-notes");
                  },
                  label: Text('Favourites'),
                ),
              ],
            )
          : SizedBox(),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          if (notesList == null)
            Center(
              child: Text(
                "No notes are available yet !",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                  itemCount: notesTitleList!.length,
                  itemBuilder: (context, index) {
                    var leadIndex = index + 1;
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ListTile(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Alert!'),
                                      content: Text(
                                        'Are you sure?  you want to add  ' +
                                            notesTitleList![index] +
                                            ' to your Favourites',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text('CANCEL'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            sharedPreferences =
                                                await SharedPreferences
                                                    .getInstance();
                                            setState(() {
                                              favnotesTitleList!
                                                  .add(notesTitleList![index]);
                                              favnotesList!
                                                  .add(notesList![index]);
                                            });

                                            List<String> favNotesTitle =
                                                favnotesTitleList!
                                                    .map((i) => i.toString())
                                                    .toList();
                                            sharedPreferences!.setStringList(
                                                "FavNotesTitleList",
                                                favNotesTitle);

                                            List<String> favNotesDescrip =
                                                favnotesList!
                                                    .map((i) => i.toString())
                                                    .toList();
                                            sharedPreferences!.setStringList(
                                                "FavNotesDescriptList",
                                                favNotesDescrip);
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                duration: Duration(seconds: 1),
                                                backgroundColor:
                                                    Colors.pinkAccent.shade100,
                                                content: Text(
                                                    notesTitleList![index] +
                                                        '  has Added.'),
                                              ),
                                            );
                                          },
                                          child: Text('ADD'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            leading: CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.greenAccent,
                              child: Text(
                                leadIndex.toString(),
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 15.0,
                                ),
                              ),
                            ),
                            title: Text(notesTitleList![index]),
                            subtitle: Text(notesList![index]),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
        ],
      )),
    );
  }

  bool noteClicked = false;
}
