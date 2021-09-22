import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_manager/sura_manager.dart';

class SuraFutureManagerExample extends StatefulWidget {
  const SuraFutureManagerExample({Key? key}) : super(key: key);

  @override
  _SuraFutureManagerExampleState createState() => _SuraFutureManagerExampleState();
}

class _SuraFutureManagerExampleState extends State<SuraFutureManagerExample> {
  FutureManager<int> numberManager = FutureManager();

  @override
  void initState() {
    numberManager.asyncOperation(
      () async {
        Future.delayed(Duration(seconds: 2));
        return 10;
      },
      reloading: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Beamer.of(context).state.uri);
    return Scaffold(
      appBar: UIHelper.CustomAppBar(
        title: "Sura FutureManager example",
        actions: [
          IconButton(
            onPressed: () {
              numberManager.refresh();
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              numberManager.addError("Now you got an error");
            },
            icon: Icon(Icons.error_outline),
          ),
        ],
      ),
      body: Center(
        child: FutureManagerBuilder(
          futureManager: numberManager,
          ready: (context, data) {
            return Text("My Number is: ${data}");
          },
        ),
      ),
    );
  }
}
