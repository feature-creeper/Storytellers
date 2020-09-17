import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: "com.storytellers.storytellers/nativecall",
    binaryMessenger: controller.binaryMessenger)
    
    //Find asset from Flutter
//    let key = controller.lookupKey(forAsset: "assets/images/rd_cbucket1.jpg")
//    let imagePath = Bundle.main.path(forResource: key, ofType: nil)
//    print("MY IMAGE PATH: \(imagePath)")
//
    let effectKey = controller.lookupKey(forAsset: "assets/effects/teddycigar")
    let effectPath = Bundle.main.path(forResource: effectKey, ofType: nil)
    print("MY EFFECT PATH: \(effectPath)")

    
    let fileManager = FileManager.default
    let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
    let myEffectPath = documentsURL.appendingPathComponent("myEffect").path
    print("DOCS URL \(myEffectPath)")
//    do {
//        let fileURLs = try fileManager.contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil)
//        // process files
//        for item in fileURLs {
//            print("PATHTHTH = \(item.path)")
//        }
//
//    } catch {
//        print("Error while enumerating files \(documentsURL.path): \(error.localizedDescription)")
//    }
    
    
    channel.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      // Note: this method is invoked on the UI thread.
        if call.method == "pushPop" {
            //result("PUSH POP!")
            
            //let storyboardName = "Main"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if #available(iOS 13.0, *) {
                
                
                if let sentText = call.arguments as? [String:Any]{
                    print(sentText["text"])
                }
                
                
                let vc = storyboard.instantiateViewController(identifier: "Success") as ViewController
                vc.modalPresentationStyle = .fullScreen
                vc.flutterResult = result
                vc.maskPath = myEffectPath//effectPath
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

//extension FileManager {
//    func urls(for directory: FileManager.SearchPathDirectory, skipsHiddenFiles: Bool = true ) -> [URL]? {
//        let documentsURL = urls(for: directory, in: .userDomainMask)[0]
//        let fileURLs = try? contentsOfDirectory(at: documentsURL, includingPropertiesForKeys: nil, options: skipsHiddenFiles ? .skipsHiddenFiles : [] )
//        return fileURLs
//    }
//}
