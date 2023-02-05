
import 'google_cast_platform_interface.dart';

class GoogleCast {
  Future<String?> getPlatformVersion() {
    return GoogleCastPlatform.instance.getPlatformVersion();
  }
}
