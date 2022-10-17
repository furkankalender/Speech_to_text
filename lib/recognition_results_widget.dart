import 'package:deneme1/buttons_widget.dart';
import 'package:deneme1/consts.dart';
import 'package:deneme1/recognition_header.dart';
import 'package:flutter/material.dart';

class RecognitionResultsWidget extends StatefulWidget {
  final bool hasSpeech;
  final Function initSpeechState;
  final Function startListening;
  final Function stopListening;
  final Function getText;

  final bool isListening;

  RecognitionResultsWidget(
      {Key? key,
      required this.lastWords,
      required this.level,
      required this.hasSpeech,
      required this.getText,
      required this.initSpeechState,
      required this.startListening,
      required this.isListening,
      required this.stopListening})
      : super(key: key);

  final String lastWords;
  final double level;

  @override
  State<RecognitionResultsWidget> createState() =>
      _RecognitionResultsWidgetState();
}

class _RecognitionResultsWidgetState extends State<RecognitionResultsWidget> {
  late TextEditingController _textEditController;
  bool isEnable = false;
  @override
  void initState() {
    _textEditController = TextEditingController();
    super.initState();
  }

  void changeEnableStatus() {
    setState(() {
      isEnable = !isEnable;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isListening) {
      _textEditController.text = widget.lastWords;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const RecognitionHeader(),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: TextFormField(
                          maxLines: 4,
                          textAlign: TextAlign.center,
                          enabled: isEnable,
                          style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 22,
                              color: textColor,
                              fontFamily: "Fjalla",
                              fontWeight: FontWeight.bold),
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          controller: _textEditController,
                        )),
                    if (!(widget.isListening))
                      IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: buttonsColor,
                        ),
                        onPressed: () {
                          widget.getText(_textEditController.text);
                          Navigator.pop(context);
                        },
                      ),
                  ],
                ),
              ),
              ButtonsWidget(
                  isEnabled: isEnable,
                  hasSpeech: widget.hasSpeech,
                  isListening: widget.isListening,
                  startListening: widget.startListening,
                  changeEnableStatus: changeEnableStatus,
                  stopListening: widget.stopListening,
                  level: widget.level),
            ],
          ),
        ),
      ],
    );
  }
}
