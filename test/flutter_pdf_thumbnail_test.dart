import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_pdf_thumbnail/flutter_pdf_thumbnail.dart';
import 'package:flutter_pdf_thumbnail/flutter_pdf_thumbnail_platform_interface.dart';
import 'package:flutter_pdf_thumbnail/flutter_pdf_thumbnail_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterPdfThumbnailPlatform
    with MockPlatformInterfaceMixin
    implements FlutterPdfThumbnailPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterPdfThumbnailPlatform initialPlatform = FlutterPdfThumbnailPlatform.instance;

  test('$MethodChannelFlutterPdfThumbnail is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterPdfThumbnail>());
  });

  test('getPlatformVersion', () async {
    FlutterPdfThumbnail flutterPdfThumbnailPlugin = FlutterPdfThumbnail();
    MockFlutterPdfThumbnailPlatform fakePlatform = MockFlutterPdfThumbnailPlatform();
    FlutterPdfThumbnailPlatform.instance = fakePlatform;

    expect(await flutterPdfThumbnailPlugin.getPlatformVersion(), '42');
  });
}
