package net.casimirlab.frigoligo

import android.content.Context
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import me.leolin.shortcutbadger.ShortcutBadger

class AppBadgePlugin : FlutterPlugin, MethodCallHandler {
  companion object {
    const val CHANNEL = "net.casimir-lab.frigoligo/appbadge"
  }

  private lateinit var channel: MethodChannel
  private lateinit var applicationContext: Context

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(binding.binaryMessenger, CHANNEL)
    channel.setMethodCallHandler(this)
    applicationContext = binding.applicationContext
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "update" -> {
        val count = call.argument<Int>("count")
        ShortcutBadger.applyCount(applicationContext, count as Int)
        result.success(null)
      }

      "remove" -> {
        ShortcutBadger.removeCount(applicationContext)
        result.success(null)
      }

      "isSupported" -> {
        result.success(ShortcutBadger.isBadgeCounterSupported(applicationContext))
      }

      else -> result.notImplemented()
    }
  }

}
