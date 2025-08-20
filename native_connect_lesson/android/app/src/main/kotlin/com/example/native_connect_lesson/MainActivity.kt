package com.example.native_connect_lesson

import android.Manifest
import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.content.pm.PackageManager
import android.location.Location
import android.location.LocationListener
import android.location.LocationManager
import android.media.AudioManager
import android.os.BatteryManager
import android.os.Build
import android.os.Bundle
import android.os.VibrationEffect
import android.os.Vibrator
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity(), LocationListener {

    // CHANNEL nomlari
    private val PLATFORM_CHANNEL = "demo/platform"
    private val BATTERY_CHANNEL = "samples.flutter.dev/battery"
    private val LOCATION_CHANNEL = "samples.flutter.dev/location"
    private val VOLUME_CHANNEL = "samples.flutter.dev/volume"
    private val VIBRATION_CHANNEL = "samples.flutter.dev/vibration"

    private val LOCATION_PERMISSION_REQUEST_CODE = 1
    private var pendingLocationResult: MethodChannel.Result? = null
    private lateinit var locationManager: LocationManager

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        locationManager = getSystemService(Context.LOCATION_SERVICE) as LocationManager

        // ✅ Platform versiyasi
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PLATFORM_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getPlatformVersion") {
                    val version = "Android ${Build.VERSION.RELEASE}"
                    result.success(version)
                } else {
                    result.notImplemented()
                }
            }

        // ✅ Battery
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BATTERY_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getBatteryLevel") {
                    val level = getBatteryLevel()
                    if (level != -1) result.success(level)
                    else result.error("UNAVAILABLE", "Battery level not available.", null)
                } else {
                    result.notImplemented()
                }
            }

        // ✅ Location
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LOCATION_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getLocation") {
                    if (pendingLocationResult != null) {
                        result.error("ALREADY_RUNNING", "Previous location request still running.", null)
                        return@setMethodCallHandler
                    }
                    pendingLocationResult = result
                    if (checkLocationPermission()) startLocationUpdates()
                    else requestLocationPermission()
                } else {
                    result.notImplemented()
                }
            }

        // ✅ Volume
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VOLUME_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getVolumeLevel") {
                    val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
                    val currentVolume = audioManager.getStreamVolume(AudioManager.STREAM_MUSIC)
                    val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
                    val volumePercent = (currentVolume * 100) / maxVolume
                    result.success(volumePercent)
                } else {
                    result.notImplemented()
                }
            }

        // ✅ Vibration
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, VIBRATION_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "vibrate") {
                    val vibrator = getSystemService(Context.VIBRATOR_SERVICE) as Vibrator
                    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                        vibrator.vibrate(VibrationEffect.createOneShot(500, VibrationEffect.DEFAULT_AMPLITUDE))
                    } else {
                        @Suppress("DEPRECATION")
                        vibrator.vibrate(500)
                    }
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }

    // 🔋 Battery darajasi olish
    private fun getBatteryLevel(): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val bm = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            bm.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext)
                .registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
            val level = intent?.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) ?: -1
            val scale = intent?.getIntExtra(BatteryManager.EXTRA_SCALE, -1) ?: -1
            if (level != -1 && scale != -1) (level * 100) / scale else -1
        }
    }

    // 📍 Location permission tekshirish
    private fun checkLocationPermission(): Boolean =
        ContextCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) ==
                PackageManager.PERMISSION_GRANTED

    private fun requestLocationPermission() {
        ActivityCompat.requestPermissions(
            this,
            arrayOf(
                Manifest.permission.ACCESS_FINE_LOCATION,
                Manifest.permission.ACCESS_COARSE_LOCATION
            ),
            LOCATION_PERMISSION_REQUEST_CODE
        )
    }

    private fun startLocationUpdates() {
        try {
            locationManager.requestLocationUpdates(
                LocationManager.GPS_PROVIDER,
                2000L,
                5f,
                this
            )
            val last = locationManager.getLastKnownLocation(LocationManager.GPS_PROVIDER)
            if (last != null) onLocationChanged(last)
        } catch (e: SecurityException) {
            pendingLocationResult?.error("PERMISSION_DENIED", "Location permission denied", null)
            pendingLocationResult = null
        }
    }

    private fun stopLocationUpdates() {
        try { locationManager.removeUpdates(this) } catch (_: Exception) {}
    }

    // 📍 Callback
    override fun onLocationChanged(location: Location) {
        val map = hashMapOf(
            "latitude" to location.latitude,
            "longitude" to location.longitude
        )
        pendingLocationResult?.success(map)
        pendingLocationResult = null
        stopLocationUpdates()
    }

    @Deprecated("Deprecated in Java")
    override fun onStatusChanged(provider: String?, status: Int, extras: Bundle?) { }

    override fun onProviderEnabled(provider: String) { }

    override fun onProviderDisabled(provider: String) {
        pendingLocationResult?.error("UNAVAILABLE", "Location provider disabled", null)
        pendingLocationResult = null
        stopLocationUpdates()
    }

    // Permission javobi
    override fun onRequestPermissionsResult(
        requestCode: Int,
        permissions: Array<String>,
        grantResults: IntArray
    ) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == LOCATION_PERMISSION_REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                startLocationUpdates()
            } else {
                pendingLocationResult?.error("PERMISSION_DENIED", "Location permission denied", null)
                pendingLocationResult = null
            }
        }
    }
}
