import 'package:flutter/material.dart';
class Utils {
  static getSnacBar({required String title, required BuildContext context}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(title),
      backgroundColor: (Colors.black12),
    ));
  }
}