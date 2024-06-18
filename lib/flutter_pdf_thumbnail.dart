// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_render/pdf_render.dart';
import 'dart:ui' as ui;

import 'flutter_pdf_thumbnail_platform_interface.dart';

class FlutterPdfThumbnail {
  static Future<Uint8List> thumbnail(String path) async {
    final String tempDirPath = (await getTemporaryDirectory()).path;
    final String fileName = path.hashCode.toString();
    final File imageFile = File('$tempDirPath/$fileName.png');

    if (await imageFile.exists()) {
      return await imageFile.readAsBytes();
    } else {
      final document = await PdfDocument.openFile(path);
      final page = await document.getPage(1); // Get the first page
      final pageImage = await page.render();
      await pageImage.createImageIfNotAvailable();

      var byteData = await pageImage.imageIfAvailable
          ?.toByteData(format: ui.ImageByteFormat.png);

      if (byteData != null) {
        final Uint8List imageData = byteData.buffer.asUint8List();
        await imageFile.writeAsBytes(imageData);
        return imageData;
      } else {
        throw Exception('Failed to generate thumbnail');
      }
    }
  }

  Future<Uint8List?> getThumbnail({required String filePath}) async {
    try {
      final Uint8List result = await thumbnail(filePath);
      return result;
    } on PlatformException catch (_) {
      rethrow;
    }
  }

  Future<String?> getPlatformVersion() {
    return FlutterPdfThumbnailPlatform.instance.getPlatformVersion();
  }
}
