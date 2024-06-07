package com.yourcompany.pdf_thumbnail_plugin

import android.graphics.Bitmap
import android.graphics.pdf.PdfRenderer
import android.os.ParcelFileDescriptor
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar
import java.io.ByteArrayOutputStream

class PdfThumbnailPlugin(private val registrar: Registrar) : MethodCallHandler {
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), "pdf_thumbnail_plugin")
      channel.setMethodCallHandler(PdfThumbnailPlugin(registrar))
    }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getThumbnail") {
      val filePath = call.argument<String>("filePath")
      filePath?.let {
        try {
          val fd = registrar.context().contentResolver.openFileDescriptor(android.net.Uri.parse(filePath), "r")
          val pdfRenderer = PdfRenderer(fd!!)
          val page = pdfRenderer.openPage(0)
          val bitmap = Bitmap.createBitmap(page.width, page.height, Bitmap.Config.ARGB_8888)
          page.render(bitmap, null, null, PdfRenderer.Page.RENDER_MODE_FOR_DISPLAY)
          page.close()
          pdfRenderer.close()
          val stream = ByteArrayOutputStream()
          bitmap.compress(Bitmap.CompressFormat.PNG, 100, stream)
          result.success(stream.toByteArray())
        } catch (e: Exception) {
          result.error("ERROR", e.message, null)
        }
      }
    } else {
      result.notImplemented()
    }
  }
}
