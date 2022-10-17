import 'package:deneme1/bottomsheet.dart';
import 'package:deneme1/consts.dart';
import 'package:deneme1/utils.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: "Recording Mars", home: MainWidget());
  }
}

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  String speechText = "";
  final PermissionHandlerPlatform _permissionHandler =
      PermissionHandlerPlatform.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: CircleAvatar(
          radius: 60,
          backgroundColor: textColor,
          child: IconButton(
            icon: const Icon(
              Icons.mic,
              color: buttonsColor,
            ),
            iconSize: 60,
            onPressed: () => showBottomSheetWidget(),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: backgroundColor,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Mars Teknolojileri Sesten yazıya uygulaması",
                    style: TextStyle(
                        fontSize: 22, fontFamily: "Fjalla", color: textColor)),
                Text(speechText,
                    style: const TextStyle(
                        fontSize: 22, fontFamily: "Fjalla", color: textColor))
              ]),
        ));
  }

  getText(String text) {
    speechText = text;
    setState(() {});
  }

  bottomSheet() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      showModalBottomSheet(
          isDismissible: false,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext ctx) {
            return Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: BottomSheedWidget(
                getText: getText,
              ),
            );
          });
    });
  }

  Future showBottomSheetWidget() async {
    var status = await Permission.speech.status;
    if ((status.isGranted)) {
      bottomSheet();
    } else if (status.isDenied) {
      final requestResult =
          await _permissionHandler.requestPermissions([Permission.speech]);
      status = await Permission.speech.status;
      if (status.isDenied) {
        if (requestResult.toString().contains("permanentlyDenied")) {
          openAppSettings();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              Utils.getSnacBar("Konuşabilmek için izin vermelisiniz"));
        }
      } else {
        bottomSheet();
      }
    }
  }
}
