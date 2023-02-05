import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'google_cast_method_channel.dart';

abstract class GoogleCastPlatform extends PlatformInterface {
  /// Constructs a GoogleCastPlatform.
  GoogleCastPlatform() : super(token: _token);

  static final Object _token = Object();

  static GoogleCastPlatform _instance = MethodChannelGoogleCast();

  /// The default instance of [GoogleCastPlatform] to use.
  ///
  /// Defaults to [MethodChannelGoogleCast].
  static GoogleCastPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [GoogleCastPlatform] when
  /// they register themselves.
  static set instance(GoogleCastPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<dynamic> showConnectionDialog() {
    throw UnimplementedError('showConnectionDialog() has not been implemented.');
  }

  Future<dynamic> isConnected() {
    throw UnimplementedError('isConnected() has not been implemented.');
  }

  Future<dynamic> showControlDialog() {
    throw UnimplementedError('showControlDialog() has not been implemented.');
  }

  Future<dynamic> startCasting(Map<String, dynamic> data) {
    throw UnimplementedError('startCasting() has not been implemented.');
  }
}
