import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';

class FirebaseCrashlyticExample extends StatefulWidget {
  const FirebaseCrashlyticExample({Key? key}) : super(key: key);

  @override
  _FirebaseCrashlyticExampleState createState() => _FirebaseCrashlyticExampleState();
}

class _FirebaseCrashlyticExampleState extends State<FirebaseCrashlyticExample> {
  Future onRecordError() async {
    try {
      await Future.delayed(Duration(seconds: 2));
      throw "Testing error";
    } catch (ex, s) {
      await FirebaseCrashlytics.instance.recordError(
        ex,
        s,
        reason: 'a fatal error',
        fatal: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Firebase crashlytic example"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              child: Text("Crash App"),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Record Error"),
            ),
          ],
        ),
      ),
    );
  }
}
