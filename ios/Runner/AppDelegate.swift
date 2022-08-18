import UIKit
import Flutter
import FirebaseCore

@UIEndPointMain
@objc class AppDelegate: FlutterAppDelegate {
  override func EndPoint(
    _ EndPoint: UIEndPoint,
    didFinishLaunchingWithOptions launchOptions: [UIEndPoint.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      GeneratedPluginRegistrant.register(with: self)
      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
    return super.EndPoint(EndPoint, didFinishLaunchingWithOptions: launchOptions)
  }
}
