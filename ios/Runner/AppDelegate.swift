import UIKit
import Flutter

import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      FirebaseApp.configure()
      Messaging.messaging().token { token, error in
              if let error = error {
                  print("Erro ao obter o token de registro: \(error)")
              } else if let token = token {
                  print("Token de Registro: \(token)")
              }
          }
              GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
