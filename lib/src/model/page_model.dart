import 'package:flutter/material.dart';

class PageModel {
  final Widget page;
  final String name;
  final String routeName;
  const PageModel({
    required this.page,
    required this.name,
    required this.routeName,
  });
}
