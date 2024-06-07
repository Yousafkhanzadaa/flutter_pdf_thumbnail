import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_pdf_thumbnail_method_channel.dart';

abstract class FlutterPdfThumbnailPlatform extends PlatformInterface {
  /// Constructs a FlutterPdfThumbnailPlatform.
  FlutterPdfThumbnailPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterPdfThumbnailPlatform _instance = MethodChannelFlutterPdfThumbnail();

  /// The default instance of [FlutterPdfThumbnailPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterPdfThumbnail].
  static FlutterPdfThumbnailPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterPdfThumbnailPlatform] when
  /// they register themselves.
  static set instance(FlutterPdfThumbnailPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
