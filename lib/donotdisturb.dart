import 'package:flutter/material.dart';

import 'package:flutter_dnd/flutter_dnd.dart';

void main() => runApp(MyApp2());

class MyApp2 extends StatefulWidget {
  @override
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> with WidgetsBindingObserver {
  String _filterName = '';
  bool _isNotificationPolicyAccessGranted = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    updateUI();
  }

  void updateUI() async {
    int filter = await FlutterDnd.getCurrentInterruptionFilter();
    String filterName = FlutterDnd.getFilterName(filter);
    bool isNotificationPolicyAccessGranted =
    await FlutterDnd.isNotificationPolicyAccessGranted;

    setState(() {
      _isNotificationPolicyAccessGranted = isNotificationPolicyAccessGranted;
      _filterName = filterName;
    });
  }

  void setInterruptionFilter(int filter) async {
    if (await FlutterDnd.isNotificationPolicyAccessGranted) {
      await FlutterDnd.setInterruptionFilter(filter);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter DND Example app'),
        ),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
              Widget>[
            Text('Current Filter: $_filterName'),
            SizedBox(
              height: 10,
            ),
            Text(
                'isNotificationPolicyAccessGranted: ${_isNotificationPolicyAccessGranted ? 'YES' : 'NO'}'),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
              onPressed: () {
                FlutterDnd.gotoPolicySettings();
              },
              child: Text('GOTO POLICY SETTINGS'),
            ),
            RaisedButton(
              onPressed: () async {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_NONE);
              },
              child: Text('TURN ON DND'),
            ),
            RaisedButton(
              onPressed: () {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALL);
              },
              child: Text('TURN OFF DND'),
            ),
            RaisedButton(
              onPressed: () {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_ALARMS);
              },
              child: Text('TURN ON DND - ALLOW ALARM'),
            ),
            RaisedButton(
              onPressed: () {
                setInterruptionFilter(FlutterDnd.INTERRUPTION_FILTER_PRIORITY);
              },
              child: Text('TURN ON DND - ALLOW PRIORITY'),
            )
          ]),
        ),
      ),
    );
  }
}
