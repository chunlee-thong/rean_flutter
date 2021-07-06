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
  CustomFormController<LoginForm> controller = CustomFormController(
    field: LoginForm(),
  );

  Future onSubmit() async {
    controller.field.email;
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
                  CustomForm(
                    controller: controller,
                    child: Text(""),
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

class CustomForm extends StatefulWidget {
  final CustomFormController controller;
  final Widget child;
  const CustomForm({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  void _initTextController() {}

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    _initTextController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () {},
      child: widget.child,
    );
  }
}

class CustomFormController<T> {
  final T field;
  CustomFormController({required this.field}) {}
}

// abstract class CustomFormField {
//   void dispse();
// }

class LoginForm {
  final String? email;
  final String? password;

  LoginForm({this.email, this.password}) {}
}
