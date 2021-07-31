import 'package:cached_network_image/cached_network_image.dart';
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:sura_flutter/sura_flutter.dart';

class DummyImageCard extends StatelessWidget {
  final int index;
  const DummyImageCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final imageWidth = 100 + index;
    final double cardHeight = 120;
    final faker = Faker();
    return Container(
      height: cardHeight,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            offset: Offset(0.0, 0.0),
            blurRadius: 10,
            spreadRadius: 5,
          )
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: cardHeight,
              height: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: SuraUtils.picsumImage(imageWidth, imageWidth),
                  fit: BoxFit.cover,
                  placeholder: (_, url) => Center(child: const CircularProgressIndicator()),
                  fadeInDuration: const Duration(milliseconds: 50),
                  fadeOutDuration: const Duration(milliseconds: 50),
                ),
              ),
            ),
            SpaceX(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(faker.food.dish(), style: context.textTheme.headline6),
                  SpaceY(),
                  Text(faker.lorem.sentence(), style: context.textTheme.bodyText1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
