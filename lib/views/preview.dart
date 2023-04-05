import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'components/rounded_button.dart';

class UnityDemoScreen extends StatefulWidget {
  // const UnityDemoScreen({Key? key}) : super(key: key);
  final String start;
  final String end;

  UnityDemoScreen({
    required this.start,
    required this.end,
  });

  @override
  _UnityDemoScreenState createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  late UnityWidgetController _unityWidgetController;

  // Communcation from Flutter to Unity
  void setNavigationTarget() {
    _unityWidgetController.postMessage(
        "PathRenderer", "SetStartNavigationTarget", widget.start);
    _unityWidgetController.postMessage(
        "PathRenderer", "SetEndNavigationTarget", widget.end);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: SafeArea(
          bottom: false,
          child: Container(
            color: Colors.amber,
            child: Stack(children: <Widget>[
              UnityWidget(
                onUnityCreated: onUnityCreated,
                onUnityMessage: onUnityMessage,
              ),
            ]),
          ),
        ));
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    _unityWidgetController = controller;
    
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) {
    if (message == "Display Path") {
      setNavigationTarget();
    } else {
      print('Received message from unity: ${message.toString()}');
    }
  }
}
