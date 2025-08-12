import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermission() async {
    if (await Permission.storage.isGranted) return true;
    if (await Permission.storage.request().isGranted) return true;

    if (await Permission.manageExternalStorage.isGranted) return true;
    if (await Permission.manageExternalStorage.request().isGranted) return true;

    return false;
  }

  static Future<bool> requestPhotosPermission() async {
    if (await Permission.photos.isGranted) return true;
    if (await Permission.photos.request().isGranted) return true;
    return false;
  }
}
