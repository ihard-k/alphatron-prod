import 'dart:io';

import 'package:game_framework/game_framework.dart';
import 'package:device_info_plus/device_info_plus.dart';

class UserConfig {
  static UserConfig? _instance;
  static String id = "";
  late DeviceSessionConfig deviceSessionConfig;

  String get socketId => "socket-$id";

  String get username => deviceSessionConfig.userName ?? "";
  String get displayName => deviceSessionConfig.displayName;

  UserConfig._();

  static UserConfig get instance {
    if (_instance == null) {
      _instance = UserConfig._();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  Future<void> init() async {
    id = await _getId();
    final displayName = "Guest-${generateRandomString(5)}";

    deviceSessionConfig =
        DeviceSessionConfig(deviceId: id, displayName: displayName);
  }

  static Future<String> _getId() async {
    id = generateRandomString(30);
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      id = iosDeviceInfo.identifierForVendor ?? id; // unique ID on iOS
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      id = androidDeviceInfo.id; // unique ID on Android
    }
    return "ID-$id".replaceAll(".", "");
  }
}
