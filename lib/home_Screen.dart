import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefSwitch extends StatefulWidget {
  @override
  _SharedPrefSwitchState createState() => _SharedPrefSwitchState();
}

class _SharedPrefSwitchState extends State<SharedPrefSwitch> {
  bool isSwitched = false;

  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  SharedPreferences? prefs;

  getValue() async {
    prefs = await _prefs;
    setState(() {
      isSwitched = (prefs!.containsKey("switchValue")
          ? prefs!.getBool("switchValue")
          : false)!;
    });
  }

  goToCounter() {
    Navigator.of(context).pushNamed("/shared_pref_counter");
  }

  goToNotes() {
    Navigator.of(context).pushNamed("/shared_pref_notes");
  }

  @override
  void initState() {
    getValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: goToCounter,
            label: Text('Counter'),
            icon: Icon(Icons.arrow_forward),
          ),
          SizedBox(width: 9),
          FloatingActionButton.extended(
            onPressed: goToNotes,
            label: Text('Notes'),
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Switch(
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                  });
                  prefs!.setBool("switchValue", isSwitched);
                }),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      )),
    );
  }
}
