import 'package:permission_handler/permission_handler.dart';
import 'package:logger/logger.dart';

class PermissionService {
  static final _logger = Logger();

  static Future<bool> requestMicrophone() async {
    try {
      var status = await Permission.microphone.status;

      if (status.isDenied) {
        status = await Permission.microphone.request();
      }

      if (status.isPermanentlyDenied) {
        _logger.w('Microphone permission permanently denied');
        return false;
      }

      return status.isGranted;
    } catch (e) {
      _logger.e('Error requesting microphone permission: $e');
      return false;
    }
  }

  static Future<bool> checkMicrophonePermission() async {
    return await Permission.microphone.isGranted;
  }

  static Future<void> openSettings() async {
    await openAppSettings();
  }
}