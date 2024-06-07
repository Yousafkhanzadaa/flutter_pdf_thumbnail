// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'package:flutter/services.dart';

import 'flutter_pdf_thumbnail_platform_interface.dart';

class FlutterPdfThumbnail {
  static const MethodChannel _channel = MethodChannel('flutter_pdf_thumbnail');

  Future<Uint8List?> getThumbnail({required String filePath}) async {
    try {
      final result =
          await _channel.invokeMethod('getThumbnail', {'filePath': filePath});
      return result;
    } on PlatformException catch (_) {
      rethrow;
    }
  }

  Future<String?> getPlatformVersion() {
    return FlutterPdfThumbnailPlatform.instance.getPlatformVersion();
  }
}
