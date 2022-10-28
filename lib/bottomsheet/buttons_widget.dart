import 'package:avatar_glow/avatar_glow.dart';
import 'package:deneme1/consts.dart';
import 'package:flutter/material.dart';

class ButtonsWidget extends StatelessWidget {
  final bool isListening;
  final bool hasSpeech;
  final bool isEnabled;
  final double level;
  final Function stopListening;
  final Function changeCheckStatus;
  final Function startListening;
  final Function changeEnableStatus;
  const ButtonsWidget(
      {super.key,
      required this.hasSpeech,
      required this.isEnabled,
      required this.changeEnableStatus,
      required this.changeCheckStatus,
      required this.isListening,
      required this.startListening,
      required this.stopListening,
      required this.level});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isListening
            ? AvatarGlow(
                animate: isListening,
                glowColor: textColor,
                endRadius: 60.0,
                duration: const Duration(milliseconds: 2000),
                repeatPauseDuration: const Duration(milliseconds: 300),
                repeat: true,
                child: IconButton(
                  iconSize: 40,
                  icon: const Icon(
                    Icons.mic,
                    color: buttonsColor,
                  ),
                  onPressed: () {
                    stopListening();
                  },
                ),
              )
            : iconButton(
                IconButton(
                    icon: const Icon(
                      Icons.repeat_sharp,
                      color: backgroundColor,
                    ),
                    onPressed: () {
                      changeCheckStatus();
                      startListening();
                    }),
              ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        if (!(isListening))
          iconButton(
            IconButton(
              icon: Icon(
                Icons.edit,
                color: isEnabled ? buttonsColor : backgroundColor,
              ),
              onPressed: () {
                changeCheckStatus();
                changeEnableStatus();
              },
            ),
          )
      ],
    );
  }

  Container iconButton(IconButton iconButton) {
    return Container(
        width: 80,
        height: 50,
        margin: EdgeInsets.only(bottom: 18),
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: iconButton);
  }
}
