import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefCounter extends StatefulWidget {
  @override
  _SharedPrefCounterState createState() => _SharedPrefCounterState();
}

class _SharedPrefCounterState extends State<SharedPrefCounter> {
  int incre = 0;
  int? savedCounter;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences? prefs;

  increment() {
    setState(() {
      incre++;
    });
    prefs!.setInt("savedCounter", incre);
  }

  decrement() {
    setState(() {
      incre--;
    });
    prefs!.setInt("savedCounter", incre);
  }

  getCountValues() async {
    prefs = await _prefs;
    savedCounter =
        prefs!.containsKey("savedCounter") ? prefs!.getInt("savedCounter") : 0;

    setState(() {
      incre = savedCounter!;
    });
  }

  @override
  void initState() {
    getCountValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Counter"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: increment,
            child: Icon(Icons.add),
          ),
          SizedBox(width: 15.0),
          FloatingActionButton(
            onPressed: decrement,
            child: Icon(CupertinoIcons.minus),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Text('Count  ' + '$incre',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
