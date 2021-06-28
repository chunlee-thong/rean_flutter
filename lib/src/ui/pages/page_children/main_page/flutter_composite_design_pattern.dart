import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';
import 'package:sura_manager/sura_manager.dart';

class FlutterCompositePatternWithContentExample extends StatefulWidget {
  const FlutterCompositePatternWithContentExample({Key? key}) : super(key: key);

  @override
  _FlutterCompositePatternWithContentExampleState createState() => _FlutterCompositePatternWithContentExampleState();
}

class _FlutterCompositePatternWithContentExampleState extends State<FlutterCompositePatternWithContentExample> {
  FutureManager<List<IContent>> contentManager = FutureManager(
    futureFunction: () async {
      await Future.delayed(Duration(seconds: 1));
      List<ContentModel> data = dummyData.map<ContentModel>((e) => ContentModel.fromJson(e)).toList();

      return data.map((e) {
        return e.getContentByType();
      }).toList();
    },
    onError: (err) {},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(
        title: "",
        actions: [
          IconButton(
            onPressed: () {
              ///mark all document as completed
              final newData = contentManager.data!.map((element) {
                if (element is ContentFile) {
                  element.contentModel.markAsCompleted();
                }
                return element;
              }).toList();
              contentManager.updateData(newData);
            },
            icon: Icon(Icons.mark_email_read),
          ),
        ],
      ),
      body: FutureManagerBuilder<List<IContent>>(
        futureManager: contentManager,
        ready: (context, contents) {
          return Column(children: contents.map((e) => e.render(context)).toList());
        },
      ),
    );
  }
}

///

abstract class IContent {
  String getName();
  Widget render(BuildContext context);
  void onClick();
}

class ContentDirectory extends StatelessWidget implements IContent {
  final ContentModel contentModel;

  ContentDirectory({Key? key, required this.contentModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  @override
  String getName() {
    return contentModel.name;
  }

  @override
  void onClick() {}

  @override
  Widget render(BuildContext context) {
    return ExpansionTile(
      title: Text(contentModel.name),
      leading: Icon(Icons.folder),
      children: contentModel.children
          .map(
            (content) => Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: content.getContentByType().render(context),
            ),
          )
          .toList(),
    );
  }
}

class ContentFile extends StatelessWidget implements IContent {
  final ContentModel contentModel;
  final IconData icon;
  const ContentFile({
    Key? key,
    required this.contentModel,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return render(context);
  }

  @override
  String getName() {
    return contentModel.name;
  }

  @override
  Widget render(BuildContext context) {
    return ListTile(
      title: Text(getName()),
      dense: true,
      onTap: onClick,
      leading: Icon(icon),
      trailing: Icon(
        Icons.check_circle_rounded,
        color: contentModel.isCompleted ? Colors.green : Colors.transparent,
      ),
      subtitle: contentModel.duration.isNotEmpty ? Text(contentModel.duration) : null,
    );
  }

  @override
  void onClick() {}
}

class ContentLesson extends ContentFile {
  ContentLesson(ContentModel contentModel)
      : super(
          contentModel: contentModel,
          icon: Icons.video_library,
        );

  @override
  void onClick() {
    super.onClick();
  }
}

class ContentDocument extends ContentFile {
  ContentDocument(ContentModel contentModel)
      : super(
          contentModel: contentModel,
          icon: Icons.document_scanner,
        );
}

class ContentQuiz extends ContentFile {
  ContentQuiz(ContentModel contentModel)
      : super(
          contentModel: contentModel,
          icon: Icons.quiz,
        );
}

class ContentModel {
  final String name;
  final String type;
  final String duration;
  bool isCompleted;
  final List<ContentModel> children;
  ContentModel({
    required this.name,
    required this.type,
    required this.isCompleted,
    required this.duration,
    required this.children,
  });

  void markAsCompleted() {
    this.isCompleted = true;
  }

  IContent getContentByType() {
    if (this.type == "Folder") {
      return ContentDirectory(contentModel: this);
    } else if (this.type == "Lesson") {
      return ContentLesson(this);
    } else if (this.type == "Quiz") {
      return ContentQuiz(this);
    } else {
      return ContentDocument(this);
    }
  }

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    return ContentModel(
      name: json["name"],
      type: json["type"],
      duration: json["duration"] ?? "",
      isCompleted: json["is_completed"] ?? false,
      children: json["children"] == null ? [] : List<ContentModel>.from(json["children"].map((data) => ContentModel.fromJson(data))),
    );
  }
}

List<Map<String, dynamic>> dummyData = [
  {
    "name": "Lesson 1",
    "type": "Folder",
    "children": [
      {
        "name": "Video 1",
        "type": "Lesson",
        "duration": "2h",
        "is_completed": true,
      },
      {
        "name": "Quiz 1",
        "type": "Quiz",
      },
      {
        "name": "Sub Lesson 1",
        "type": "Folder",
        "children": [
          {
            "name": "Document sub 1",
            "type": "Document",
            "is_completed": true,
          },
          {
            "name": "Document sub 2",
            "type": "Document",
          },
        ]
      },
    ],
  },
  {
    "name": "Quiz 1",
    "type": "Quiz",
    "is_completed": true,
  },
  {
    "name": "Document 1",
    "type": "Document",
  },
];
