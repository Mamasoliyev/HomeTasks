import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_toastr/flutter_toastr.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.dark(), home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 📡 Platform kanallari
  static const _platform = MethodChannel('demo/platform');
  static const batteryChannel = MethodChannel('samples.flutter.dev/battery');
  static const locationChannel = MethodChannel('samples.flutter.dev/location');
  static const volumeChannel = MethodChannel('samples.flutter.dev/volume');
  static const vibrationChannel = MethodChannel(
    'samples.flutter.dev/vibration',
  );

  String _batteryLevel = "Noma'lum";
  String _location = "Joylashuv aniqlanmadi";
  String _volume = "Ovoz darajasi noma'lum";

  // 🔹 Platform versiya olish
  Future<String> _getPlatformVersion() async {
    try {
      final v = await _platform.invokeMethod<String>('getPlatformVersion');
      return v ?? 'Noma’lum';
    } on PlatformException catch (e) {
      return 'Xato: ${e.message}';
    }
  }

  // 🔋 Battery darajasi
  Future<void> _getBatteryLevel() async {
    try {
      final int result = await batteryChannel.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = "Batareya: $result% 🔋";
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = "Xato: ${e.message}";
      });
    }
  }

  // 📍 Location olish
  Future<void> _getLocation() async {
    try {
      final Map<dynamic, dynamic> result = await locationChannel.invokeMethod(
        'getLocation',
      );
      setState(() {
        _location =
            "Latitude: ${result['latitude']}, Longitude: ${result['longitude']}";
      });
    } on PlatformException catch (e) {
      setState(() {
        _location = "Joylashuv olishda xato: ${e.message}";
      });
    }
  }

  // 🔊 Volume olish
  Future<void> _getVolumeLevel() async {
    try {
      final int result =
          await volumeChannel.invokeMethod<int>('getVolumeLevel') ?? -1;
      setState(() {
        _volume = "Ovoz darajasi: $result% 🔊";
      });
    } on PlatformException catch (e) {
      setState(() {
        _volume = "Ovoz darajasini olishda xato: ${e.message}";
      });
    }
  }

  // 📳 Vibratsiya
  Future<void> _vibrate(BuildContext ctx) async {
    try {
      await vibrationChannel.invokeMethod('vibrate');
      FlutterToastr.show(
        "Vibratsiya bo'lmoqda...",
        ctx, // 👈 Scaffold context berilmoqda
        duration: FlutterToastr.lengthShort,
        position: FlutterToastr.bottom,
      );
    } on PlatformException catch (e) {
      debugPrint("Vibratsiya ishlamadi: ${e.message}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Platform Channel: Full Example'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 📱 Platform versiya
              FutureBuilder(
                future: _getPlatformVersion(),
                builder: (context, snap) {
                  if (!snap.hasData) return const CircularProgressIndicator();
                  return Text('Platform versiya: ${snap.data}');
                },
              ),
              const SizedBox(height: 24),

              // 🔋 Battery
              Text(_batteryLevel, style: const TextStyle(fontSize: 20)),
              ElevatedButton(
                onPressed: _getBatteryLevel,
                child: const Text("Batareya darajasini olish"),
              ),
              const SizedBox(height: 30),

              // 📍 Location
              Text(_location, style: const TextStyle(fontSize: 20)),
              ElevatedButton(
                onPressed: _getLocation,
                child: const Text("Joylashuvni olish"),
              ),
              const SizedBox(height: 30),

              // 🔊 Volume
              Text(_volume, style: const TextStyle(fontSize: 20)),
              ElevatedButton(
                onPressed: _getVolumeLevel,
                child: const Text("Ovoz darajasini olish"),
              ),
              const SizedBox(height: 30),

              // 📳 Vibratsiya
              ElevatedButton(
                onPressed: () => _vibrate(context),
                child: const Text("Vibratsiya qilish"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
