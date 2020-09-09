import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.storytellers.storytellers/nativecall",
    binaryMessenger: controller.binaryMessenger)
    
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
        if call.method == "pushPop" {
            //result("PUSH POP!")
            
            //let storyboardName = "Main"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 13.0, *) {
                let vc = storyboard.instantiateViewController(identifier: "Success") as ViewController
                vc.modalPresentationStyle = .fullScreen
                vc.flutterResult = result
                controller.present(vc, animated: true, completion: nil)
            } else {
                // Fallback on earlier versions
            }
//            controller.present(storyboard, animated: true, completion: nil)
            
//            NSString * storyboardName = @"Main";
//            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
//            UIViewController * view_from_board = [storyboard instantiateViewControllerWithIdentifier:@"NativeViewController"];
//            [self.navigationController pushViewController:view_from_board animated:true];
        }else if call.method == "sayHello"{
            result("Hello")
        }
        else{
            result(FlutterMethodNotImplemented)
        }
        
        
    })
    
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
     func receiveBatteryLevel(result: FlutterResult) {
      let device = UIDevice.current
      device.isBatteryMonitoringEnabled = true
      if device.batteryState == UIDevice.BatteryState.unknown {
        result(FlutterError(code: "UNAVAILABLE",
                            message: "Battery info unavailable",
                            details: nil))
      } else {
        result(Int(device.batteryLevel * 100))
      }
    }
}
