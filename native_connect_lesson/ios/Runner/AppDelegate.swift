import UIKit
import Flutter
import CoreLocation
import AVFoundation
import AudioToolbox

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate, CLLocationManagerDelegate {

  // Channel nomlari
  private let PLATFORM_CHANNEL = "demo/platform"
  private let BATTERY_CHANNEL = "samples.flutter.dev/battery"
  private let LOCATION_CHANNEL = "samples.flutter.dev/location"
  private let VOLUME_CHANNEL = "samples.flutter.dev/volume"
  private let VIBRATION_CHANNEL = "samples.flutter.dev/vibration"

  // Location manager va natija saqlash
  private let locationManager = CLLocationManager()
  private var pendingLocationResult: FlutterResult?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController

    // --- PLATFORM CHANNEL ---
    let platformChannel = FlutterMethodChannel(
      name: PLATFORM_CHANNEL,
      binaryMessenger: controller.binaryMessenger
    )
    platformChannel.setMethodCallHandler { call, result in
      if call.method == "getPlatformVersion" {
        result("iOS \(UIDevice.current.systemVersion)")
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // --- BATTERY CHANNEL ---
    let batteryChannel = FlutterMethodChannel(
      name: BATTERY_CHANNEL,
      binaryMessenger: controller.binaryMessenger
    )
    batteryChannel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { return }
      if call.method == "getBatteryLevel" {
        self.receiveBatteryLevel(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // --- LOCATION CHANNEL ---
    let locationChannel = FlutterMethodChannel(
      name: LOCATION_CHANNEL,
      binaryMessenger: controller.binaryMessenger
    )
    locationChannel.setMethodCallHandler { [weak self] call, result in
      guard let self = self else { return }
      if call.method == "getLocation" {
        self.receiveLocation(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // --- VOLUME CHANNEL ---
    let volumeChannel = FlutterMethodChannel(
      name: VOLUME_CHANNEL,
      binaryMessenger: controller.binaryMessenger
    )
    volumeChannel.setMethodCallHandler { call, result in
      if call.method == "getVolumeLevel" {
        self.receiveVolumeLevel(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // --- VIBRATION CHANNEL ---
    let vibrationChannel = FlutterMethodChannel(
      name: VIBRATION_CHANNEL,
      binaryMessenger: controller.binaryMessenger
    )
    vibrationChannel.setMethodCallHandler { call, result in
      if call.method == "vibrate" {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        result(true)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    // Location manager setup
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - Battery
  private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    defer { device.isBatteryMonitoringEnabled = false }

    if device.batteryState == .unknown {
      result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available.", details: nil))
    } else {
      result(Int(device.batteryLevel * 100))
    }
  }

  // MARK: - Volume
  private func receiveVolumeLevel(result: FlutterResult) {
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setActive(true)
      let volume = audioSession.outputVolume
      result(Double(volume)) // 0.0 – 1.0 oralig‘ida
    } catch {
      result(FlutterError(code: "UNAVAILABLE", message: "Failed to get volume", details: nil))
    }
  }

  // MARK: - Location
  private func receiveLocation(result: @escaping FlutterResult) {
    if pendingLocationResult != nil {
      result(FlutterError(code: "ALREADY_RUNNING", message: "Previous location request is still in progress.", details: nil))
      return
    }
    pendingLocationResult = result

    let status: CLAuthorizationStatus
    if #available(iOS 14.0, *) {
      status = locationManager.authorizationStatus
    } else {
      status = CLLocationManager.authorizationStatus()
    }

    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      locationManager.requestLocation()
    case .notDetermined:
      locationManager.requestWhenInUseAuthorization()
    default:
      result(FlutterError(code: "PERMISSION_DENIED", message: "Location permission denied", details: nil))
      pendingLocationResult = nil
    }
  }

  // CLLocationManagerDelegate
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let loc = locations.last else { return }
    let payload: [String: Any] = [
      "latitude": loc.coordinate.latitude,
      "longitude": loc.coordinate.longitude
    ]
    pendingLocationResult?(payload)
    pendingLocationResult = nil
  }

  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    pendingLocationResult?(
      FlutterError(code: "LOCATION_ERROR", message: error.localizedDescription, details: nil)
    )
    pendingLocationResult = nil
  }

  func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    handleAuthChange(manager)
  }

  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    handleAuthChange(manager)
  }

  private func handleAuthChange(_ manager: CLLocationManager) {
    let status: CLAuthorizationStatus
    if #available(iOS 14.0, *) {
      status = manager.authorizationStatus
    } else {
      status = CLLocationManager.authorizationStatus()
    }
    switch status {
    case .authorizedWhenInUse, .authorizedAlways:
      manager.requestLocation()
    case .denied, .restricted:
      pendingLocationResult?(
        FlutterError(code: "PERMISSION_DENIED", message: "Location permission denied", details: nil)
      )
      pendingLocationResult = nil
    default:
      break
    }
  }
}
