import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'google_cast_platform_interface.dart';

/// An implementation of [GoogleCastPlatform] that uses method channels.
class MethodChannelGoogleCast extends GoogleCastPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('google_cast');

  @override
  Future<dynamic> showConnectionDialog() async {
    return await methodChannel.invokeMethod('show_connection_dialog');
  }

  @override
  Future<dynamic> isConnected() async {
    return await methodChannel.invokeMethod('is_connected');
  }

  @override
  Future<dynamic> showControlDialog() async {
    return await methodChannel.invokeMethod('show_control_dialog');
  }

  @override
  Future<dynamic> startCasting(Map<String, dynamic> data) async {
    return await methodChannel.invokeMethod('start_casting', data);
  }
}
