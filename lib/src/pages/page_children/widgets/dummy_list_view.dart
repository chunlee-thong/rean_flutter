import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:rean_flutter/src/ui/widgets/card/dummy_image_card.dart';

class DummyTileListView extends StatelessWidget {
  final ScrollController? scrollController;
  final int count;
  const DummyTileListView({
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

class DummyImageListView extends StatelessWidget {
  final ScrollController? scrollController;
  final int count;
  const DummyImageListView({
    Key? key,
    this.scrollController,
    this.count = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      itemCount: count,
      itemBuilder: (o, index) {
        return DummyImageCard(index: index);
      },
    );
  }
}

class DummyListTile extends StatelessWidget {
  final int index;
  const DummyListTile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final faker = Faker();
    return ListTile(
      leading: CircleAvatar(
        child: Icon(
          Icons.person,
          color: Colors.black,
          size: 18,
        ),
      ),
      title: Text(faker.person.name()),
      subtitle: Text(faker.lorem.sentence()),
    );
  }
}
