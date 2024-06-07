import Flutter
import UIKit
import PDFKit

public class PdfThumbnailPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_pdf_thumbnail", binaryMessenger: registrar.messenger())
    let instance = PdfThumbnailPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if call.method == "getThumbnail" {
      guard let args = call.arguments as? [String: Any],
            let filePath = args["filePath"] as? String else {
        result(FlutterError(code: "INVALID_ARGS", message: "Invalid arguments", details: nil))
        return
      }

      guard let url = URL(string: filePath),
            let pdfDocument = PDFDocument(url: url) else {
        result(FlutterError(code: "PDF_ERROR", message: "Error loading PDF", details: nil))
        return
      }

      guard let page = pdfDocument.page(at: 0) else {
        result(FlutterError(code: "PDF_PAGE_ERROR", message: "Error getting PDF page", details: nil))
        return
      }

      let pageRect = page.bounds(for: .mediaBox)
      let renderer = UIGraphicsImageRenderer(size: pageRect.size)
      let image = renderer.image { ctx in
        page.draw(with: .mediaBox, to: ctx.cgContext)
      }

      guard let imageData = image.pngData() else {
        result(FlutterError(code: "IMAGE_ERROR", message: "Error creating image data", details: nil))
        return
      }
      result(FlutterStandardTypedData(bytes: imageData))
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}
