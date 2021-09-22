import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_flutter/sura_flutter.dart';

class FlutterDynamicFormExample extends StatefulWidget {
  const FlutterDynamicFormExample({Key? key}) : super(key: key);

  @override
  _FlutterDynamicFormExampleState createState() => _FlutterDynamicFormExampleState();
}

class _FlutterDynamicFormExampleState extends State<FlutterDynamicFormExample> {
  List<PersonForm> persons = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(
        title: "Flutter Dynamic Form",
        actions: [
          IconButton(
            icon: Icon(Icons.assessment),
            onPressed: () {
              print(persons);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: persons.map((e) => e.build()).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final key = DateTime.now().millisecondsSinceEpoch;
          persons.add(
            PersonForm(
              key: ValueKey(key),
              onDeleted: (data) {
                persons.remove(data);
                setState(() {});
              },
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}

class PersonForm {
  late TextEditingController nameTC;
  String? gender = null;
  bool isProMember = false;
  double completed = 0.0;
  final Key key;
  final void Function(PersonForm) onDeleted;

  PersonForm({
    required this.key,
    required this.onDeleted,
  }) {
    nameTC = TextEditingController();
  }

  @override
  String toString() {
    return "{${nameTC.text}, $gender, $isProMember, $completed}";
  }

  Widget build() {
    return StatefulBuilder(
      builder: (context, setState) => Card(
        margin: EdgeInsets.only(bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SuraIconButton(
                onTap: () {
                  onDeleted.call(this);
                },
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.all(8),
                backgroundColor: Colors.red,
                icon: Icon(Icons.close, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: nameTC,
                validator: (value) => value?.isEmpty ?? false ? "Please input a name" : null,
                decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButtonFormField<String>(
                items: ["Male", "Female"]
                    .map(
                      (e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  gender = value;
                  setState(() {});
                },
                value: gender,
                hint: Text("Gender"),
                validator: (value) => value?.isEmpty ?? false ? "Please input a gender" : null,
              ),
            ),
            SpaceY(16),
            SwitchListTile.adaptive(
              value: isProMember,
              onChanged: (value) {
                isProMember = value;
                setState(() {});
              },
              title: Text("Pro Membership"),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 8),
              child: Text(
                "Completion",
                style: TextStyle(fontSize: 16),
              ),
            ),
            Slider.adaptive(
              value: completed,
              min: 0.0,
              max: 100.0,
              onChanged: (value) {
                completed = value;
                setState(() {});
              },
              label: "Completion",
            )
          ],
        ),
      ),
    );
  }
}
