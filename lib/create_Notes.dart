import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:form_field_validator/form_field_validator.dart';

class SharedPrefNotes extends StatefulWidget {
  @override
  _SharedPrefNotesState createState() => _SharedPrefNotesState();
}

class _SharedPrefNotesState extends State<SharedPrefNotes> {
  List<dynamic> notesTitleList = [];
  List<dynamic> notesList = [];

  TextEditingController notesTitleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  SharedPreferences? sharedPreferences;

  addNote() {
    if (key.currentState!.validate()) {
      setState(() {
        notesTitleList.add(notesTitleController.text);

        notesList.add(notesController.text);
      });
      saveNotes();
      notesTitleController.clear();
      notesController.clear();
    }
  }

  saveNotes() async {
    sharedPreferences = await SharedPreferences.getInstance();

    List<String> saveNotesTitle =
        notesTitleList.map((i) => i.toString()).toList();
    sharedPreferences!.setStringList("notesTitleList", saveNotesTitle);

    List<String> saveNotes = notesList.map((i) => i.toString()).toList();
    sharedPreferences!.setStringList("notesList", saveNotes);
  }

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

  goToNotes() {
    Navigator.of(context).pushNamed("/notes");
  }

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: notesList.length >= 1
          ? FloatingActionButton(
              onPressed: goToNotes,
              child: Icon(Icons.notes),
            )
          : SizedBox(),
      appBar: AppBar(
        centerTitle: true,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Create Notes"),
      ),
      body: SafeArea(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  style: TextStyle(fontStyle: FontStyle.italic),
                  validator: RequiredValidator(
                    errorText: 'Please enter title!',
                  ),
                  controller: notesTitleController,
                  decoration: InputDecoration(
                    labelText: "Enter note title",
                    labelStyle: TextStyle(fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextFormField(
                  style: TextStyle(fontStyle: FontStyle.italic),
                  validator: RequiredValidator(
                    errorText: 'Please enter description!',
                  ),
                  controller: notesController,
                  decoration: InputDecoration(
                    labelText: "Enter note description",
                    labelStyle: TextStyle(fontStyle: FontStyle.normal),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(33.0, 13.0, 33.0, 15.0),
                  onPressed: addNote,
                  child: Text(
                    'Save Note',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        fontSize: 13.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey<FormState> key = GlobalKey<FormState>();
}
