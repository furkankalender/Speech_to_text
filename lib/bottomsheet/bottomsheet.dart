import 'dart:async';
import 'dart:math';
import 'package:deneme1/consts.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'recognition_results_widget.dart';

class BottomSheedWidget extends StatefulWidget {
  final Function getText;
  const BottomSheedWidget({
    Key? key,
    required this.getText,
  }) : super(key: key);
  @override
  BottomSheedWidgetState createState() => BottomSheedWidgetState();
}

class BottomSheedWidgetState extends State<BottomSheedWidget> {
  @override
  void initState() {
    initSpeechState();
    super.initState();
  }

  bool _hasSpeech = false;

  double level = 0.0;
  double minSoundLevel = 50000;
  double maxSoundLevel = -60000;
  String lastWords = '';
  String _currentLocaleId = '';
  bool firstTry = false;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();

  Future<void> initSpeechState() async {
    try {
      var hasSpeech = await speech.initialize(
          debugLogging: true, onStatus: statusListener, onError: errorListener);
      if (hasSpeech) {
        _localeNames = await speech.locales();

        var systemLocale = await speech.systemLocale();
        _currentLocaleId = "tr_TR";
      }
      if (!mounted) return;

      setState(() {
        _hasSpeech = hasSpeech;
        startListening();
      });
    } catch (e) {
      setState(() {
        _hasSpeech = false;
      });
    }
  }

  void statusListener(String status) {
    if (!mounted) {
      return;
    }
    debugPrint("isListening Status: ${speech.isListening}");
    setState(() {});
  }

  void errorListener(SpeechRecognitionError error) {
    if (!mounted) {
      return;
    }
    setState(() {
      debugPrint("error: ${error.errorMsg}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: backgroundColor,
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(children: [
            Expanded(
              flex: 4,
              child: RecognitionResultsWidget(
                  lastWords: lastWords,
                  getText: widget.getText,
                  level: level,
                  hasSpeech: _hasSpeech,
                  initSpeechState: initSpeechState,
                  startListening: startListening,
                  isListening: speech.isListening,
                  stopListening: stopListening),
            ),
          ]),
        )
      ],
    );
  }

  void startListening() {
    lastWords = '';
    debugPrint(_currentLocaleId);
    speech.listen(
        onResult: resultListener,
        listenFor: const Duration(seconds: 30),
        pauseFor: const Duration(seconds: 5),
        partialResults: true,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
  }

  void stopListening() {
    speech.stop().then(
      (value) {
        setState(() {
          level = 0.0;
        });
      },
    );
  }

  void resultListener(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);
    setState(() {
      this.level = level;
    });
  }
}
