import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class FlutterCustomForm extends StatefulWidget {
  const FlutterCustomForm({Key? key}) : super(key: key);

  @override
  _FlutterCustomFormState createState() => _FlutterCustomFormState();
}

class _FlutterCustomFormState extends State<FlutterCustomForm> {
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Flutter Custom Form"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Container(
          width: 300,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please input your username";
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Username",
                  ),
                ),
                SuraRaisedButton(
                  fullWidth: true,
                  onPressed: () {
                    formKey.currentState!.validate();
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
