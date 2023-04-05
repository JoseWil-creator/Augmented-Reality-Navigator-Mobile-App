import UIKit
import Flutter
import flutter_unity_widget
import Firebase
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    InitUnityIntegrationWithOptions(argc: CommandLine.argc, argv: CommandLine.unsafeArgv, launchOptions)
    FirebaseApp.configure() //add this before the code below
    GeneratedPluginRegistrant.register(with: self)
     GMSServices.provideAPIKey("AIzaSyDZAM1_YKEux_XQ6rcP7XPgcb-o_YBlVjs")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}