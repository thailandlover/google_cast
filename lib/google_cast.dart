
import 'google_cast_platform_interface.dart';

class GoogleCast {
  Future<dynamic> showConnectionDialog() {
    return GoogleCastPlatform.instance.showConnectionDialog();
  }

  Future<dynamic> isConnected() {
    return GoogleCastPlatform.instance.isConnected();
  }

  Future<dynamic> showControlDialog() {
    return GoogleCastPlatform.instance.showControlDialog();
  }

  Future<dynamic> startCasting(Map<String, dynamic> data) {
    return GoogleCastPlatform.instance.startCasting(data);
  }
}
