import 'package:flutter/material.dart';
import 'package:rean_flutter/src/constant/style_decoration.dart';
import 'package:rean_flutter/src/ui/widgets/ui_helper.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UIHelper.CustomAppBar(title: ""),
      body: Center(
        child: Text(
          "404 Page not found",
          style: kHeaderStyle,
        ),
      ),
    );
  }
}
