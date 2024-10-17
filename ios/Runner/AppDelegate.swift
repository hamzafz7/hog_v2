import Flutter
import UIKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  // Add a variable to track screen security state
  var windowSecurityEnabled = false

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // Standard Flutter setup
    GeneratedPluginRegistrant.register(with: self)
    
    // Get the root FlutterViewController
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController

    // Set up a MethodChannel to communicate with Flutter
    let screenSecurityChannel = FlutterMethodChannel(
        name: "com.house_of_genuises/screen_security",
        binaryMessenger: controller.binaryMessenger
    )

    // Handle method calls from Flutter
    screenSecurityChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "toggleScreenSecurity" {
        // Expecting a boolean argument (isSecure)
        if let args = call.arguments as? [String: Any],
           let isSecure = args["isSecure"] as? Bool {
          // Call the function to toggle screen security based on isSecure
          self.toggleScreenSecurity(isSecure: isSecure)
          result(nil) // Send success response back to Flutter
        } else {
          result(FlutterError(
            code: "INVALID_ARGUMENT",
            message: "Invalid argument passed",
            details: nil
          ))
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Function to enable/disable screen security
  func toggleScreenSecurity(isSecure: Bool) {
    if isSecure {
      // Disable screenshots and screen recordings
      window?.layer.isOpaque = true
      window?.layer.contents = nil // Ensures blank view during screenshots
      print("Screen security enabled: Screenshots and recordings are disabled")
    } else {
      // Enable screenshots and screen recordings
      window?.layer.isOpaque = false
      print("Screen security disabled: Screenshots and recordings are allowed")
    }
  }
}
