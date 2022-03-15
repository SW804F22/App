import UIKit
import Flutter
import flutter_config
import google_maps_flutter





@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    var mapsApiKey = FlutterConfigPlugin .env(for: "MAPS_API_KEY");
    GMSServices.provideAPIKey(mapsApiKey!)
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
