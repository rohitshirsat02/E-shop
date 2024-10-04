import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // Method to check storage permission
  Future<bool> checkPermissions() async {
    // Check if the storage permission is granted
    PermissionStatus storageStatus = await Permission.storage.status;

    // Return true if storage permission is granted
    return storageStatus.isGranted;
  }

  // Method to request storage permission
  Future<bool> requestPermissions() async {
    // Request storage permission
    PermissionStatus storageStatus = await Permission.storage.request();

    // Return true if storage permission is granted
    return storageStatus.isGranted;
  }
}
