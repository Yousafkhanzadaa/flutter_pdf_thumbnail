import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_pdf_thumbnail_platform_interface.dart';

/// An implementation of [FlutterPdfThumbnailPlatform] that uses method channels.
class MethodChannelFlutterPdfThumbnail extends FlutterPdfThumbnailPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_pdf_thumbnail');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
