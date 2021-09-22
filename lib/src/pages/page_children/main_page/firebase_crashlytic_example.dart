import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class FirebaseCrashlyticExample extends StatefulWidget {
  const FirebaseCrashlyticExample({Key? key}) : super(key: key);

  @override
  _FirebaseCrashlyticExampleState createState() => _FirebaseCrashlyticExampleState();
}

class _FirebaseCrashlyticExampleState extends State<FirebaseCrashlyticExample> {
  Future onRecordError() async {
    try {
      FirebaseCrashlytics.instance.setUserIdentifier("test-user");
      await Future.delayed(Duration(seconds: 2));
      int number = int.parse("32f");
    } catch (ex, s) {
      print(ex);
      print('stack ${s.toString()}');
      await FirebaseCrashlytics.instance.recordError(
        ex,
        s,
        reason: 'just testing only',
        fatal: false,
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
            Text("Crashlytic doesn't work on Web yet!"),
            SpaceY(),
            ElevatedButton(
              onPressed: () {
                FirebaseCrashlytics.instance.crash();
              },
              child: Text("Crash App"),
            ),
            SpaceY(16),
            ElevatedButton(
              onPressed: onRecordError,
              child: Text("Record Error"),
            ),
          ],
        ),
      ),
    );
  }
}
