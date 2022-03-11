import UIKit
import Flutter
import flutter_config
FlutterConfigPlugin.env(for: "MAPS_API_KEY")

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  NSString* mapsApiKey = [[NSProcessInfo processInfo] environment[@"MAPS_API_KEY"];
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey(mapsApiKey)
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
