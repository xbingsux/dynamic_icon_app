import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  func switchAppIcon(toChristmas: Bool) {
    // ตรวจสอบว่า iOS รองรับการเปลี่ยนไอคอนหรือไม่
    guard UIApplication.shared.supportsAlternateIcons else {
        print("Alternate Icons are not supported on this device.")
        return
    }

    // เลือกไอคอนที่ต้องการ (nil = ไอคอนหลัก)
    let iconName = toChristmas ? "ChristmasIcon" : nil

    // เปลี่ยนไอคอน
    UIApplication.shared.setAlternateIconName(iconName) { error in
        if let error = error {
            print("Error changing app icon: \(error.localizedDescription)")
        } else {
            print("App icon changed successfully!")
        }
    }
}
}

