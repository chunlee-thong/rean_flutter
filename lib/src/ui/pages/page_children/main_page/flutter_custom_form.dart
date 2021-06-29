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

  String? usernameExistError = null;

  Future onSubmit() async {
    if (formKey.currentState!.validate()) {
      await asyncValidate();
    }
  }

  Future asyncValidate() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      usernameExistError = "Username already taken";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Flutter Custom Form"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Container(
            width: 300,
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please input your username";
                      }
                    },
                    onChanged: (value) {
                      if (usernameExistError != null) {
                        setState(() {
                          usernameExistError = null;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Username",
                      errorText: usernameExistError,
                    ),
                  ),
                  SuraAsyncButton(
                    fullWidth: true,
                    onPressed: onSubmit,
                    child: Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
