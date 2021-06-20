import 'package:flutter/material.dart';
import 'package:rean_flutter/src/constant/app_theme_color.dart';
import 'package:rean_flutter/src/constant/style_decoration.dart';
import 'package:rean_flutter/src/model/page_model.dart';
import 'package:sura_flutter/sura_flutter.dart';

class PageCardItem extends StatelessWidget {
  final PageModel page;

  const PageCardItem({Key? key, required this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          PageNavigator.push(context, page.page);
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.phone_android,
                color: AppColor.primary,
                size: 30,
              ),
              SpaceY(),
              Text(
                page.name,
                textAlign: TextAlign.center,
                style: kTitleStyle.medium,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
