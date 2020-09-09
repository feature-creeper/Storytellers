import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class RoleSelectViewModel with ChangeNotifier {
  static const MethodChannel nativeCallChannel =
      const MethodChannel('com.storytellers.storytellers/nativecall');

  launchDeepAR() async {
    String info;
    try {
      info = await nativeCallChannel.invokeMethod("pushPop");
    } on PlatformException {
      info = "Failed to push native view.";
    }

    print("info $info");
  }
}
