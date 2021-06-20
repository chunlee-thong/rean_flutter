import 'package:flutter/material.dart';

class DummyListView extends StatelessWidget {
  final ScrollController? scrollController;
  final int count;
  const DummyListView({
    Key? key,
    this.scrollController,
    this.count = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        children: List.generate(
          count,
          (index) => DummyListTile(index: index),
        ),
      ),
    );
  }
}

class DummyListTile extends StatelessWidget {
  final int index;
  const DummyListTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Icon(Icons.add_moderator),
      ),
      title: Text("Title index: $index"),
      subtitle: Text("Very nice subtitle"),
    );
  }
}
