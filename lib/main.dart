import 'package:flutter/material.dart';
import 'Counter.dart';
import 'create_Notes.dart';
import 'home_Screen.dart';
import 'notes_Screen.dart';
import 'favourite_Notes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: SharedPrefSwitch(),
      routes: {
        "/shared-pref_switch": (context) => SharedPrefSwitch(),
        "/shared_pref_counter": (context) => SharedPrefCounter(),
        "/shared_pref_notes": (context) => SharedPrefNotes(),
        "/notes": (context) => Notes(),
        "/fav-notes": (context) => FavNotes()
      },
    );
  }
}
