import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LiveScreen extends StatelessWidget {
  static const MethodChannel nativeCallChannel =
      const MethodChannel('com.storytellers.storytellers/nativecall');

  Future<Null> _sayHello() async {
    String info;
    try {
      info = await nativeCallChannel.invokeMethod("sayHello");
    } on PlatformException {
      info = "Failed to call sayHello";
    }

    print(info);
  }

  Future<Null> _pushAndPopNativeView() async {
    print("TRYING TO PUSH ");
    String info;
    try {
      info = await nativeCallChannel.invokeMethod("pushPop");
    } on PlatformException {
      info = "Failed to push native view.";
    }

    print(info);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LIVE VIEW")),
      body: Container(
        child: FlatButton(
            onPressed: () => _pushAndPopNativeView(), child: Text("SAY HELLO")),
      ),
    );
  }
}
