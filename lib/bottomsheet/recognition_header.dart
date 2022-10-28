import 'package:deneme1/consts.dart';
import 'package:flutter/material.dart';

class RecognitionHeader extends StatelessWidget {
  const RecognitionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            "Mars Sesten yazıya prototip",
            style: TextStyle(fontSize: 22, color: textColor),
          ),
          IconButton(
              icon: const Icon(
                Icons.cancel_presentation,
                size: 30,
                color: buttonsColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
    );
  }
}
