import 'package:flutter/material.dart';
import 'package:rean_flutter/src/constant/style_decoration.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class FlutterFontTesting extends StatefulWidget {
  const FlutterFontTesting({Key? key}) : super(key: key);

  @override
  _FlutterFontTestingState createState() => _FlutterFontTestingState();
}

class _FlutterFontTestingState extends State<FlutterFontTesting> {
  GlobalKey<FormState> formKey = GlobalKey();

  String? khValue;
  String? enValue;

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontFamily: "Gilroy",
      fontSize: 16,
      letterSpacing: 2.0,
      // height: 1.0,
      //backgroundColor: Colors.red,
    );
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: "Flutter Font testing"),
      body: Center(
        child: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.always,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text("$khValue"),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  color: Colors.blue,
                  child: Column(
                    children: [
                      Container(
                        height: 68,
                        color: Colors.orange,
                      ),
                      Row(
                        children: [
                          Container(
                            color: Colors.red,
                            child: Text(
                              "$khValue",
                              style: style,
                              strutStyle: StrutStyle(
                                fontSize: style.fontSize,
                                height: 1.5,
                              ),
                            ),
                          ),
                          Container(
                            color: Colors.red,
                            child: Text(
                              "$enValue",
                              style: style,
                              strutStyle: StrutStyle(
                                fontSize: style.fontSize,
                                height: 1.5,
                                leadingDistribution: TextLeadingDistribution.even,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SpaceY(0),
                DropdownButtonFormField<String?>(
                  items: ["វិទ្យាសាស្រ្តុ", "ស្រី", "English"].map((e) {
                    return DropdownMenuItem<String?>(
                      child: Text(
                        e,
                        style: TextStyle(
                          height: 1.0,
                        ),
                      ),
                      value: e,
                    );
                  }).toList(),
                  value: khValue,
                  onChanged: (value) {
                    setState(() {
                      this.khValue = value;
                    });
                  },
                ),
                DropdownButtonFormField<String?>(
                  items: ["Male", "Female"].map((e) {
                    return DropdownMenuItem<String?>(
                      child: Text(
                        e,
                        style: TextStyle(
                          fontFamily: "Gilroy",
                          //fontSize: 16,
                        ),
                        strutStyle: StrutStyle(
                          fontFamily: 'Roboto',
                          fontSize: 12,
                          height: 1.0,
                        ),
                      ),
                      value: e,
                    );
                  }).toList(),
                  value: enValue,
                  onChanged: (value) {
                    setState(() {
                      this.enValue = value;
                    });
                  },
                ),
                SuraAsyncButton(
                  fullWidth: true,
                  onPressed: () {},
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
