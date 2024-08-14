package net.casimirlab.frigoligo

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import java.net.URLEncoder

class MainActivity : FlutterActivity() {
  companion object {
    const val TAG = "MainActivity"
  }

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    flutterEngine.plugins.add(AppBadgePlugin())
  }

  override fun onCreate(savedInstanceState: Bundle?) {
    super.onCreate(savedInstanceState)
    handleShareIntent(intent)
  }

  override fun onNewIntent(intent: Intent) {
    super.onNewIntent(intent)
    handleShareIntent(intent)
  }

  private fun handleShareIntent(intent: Intent?) {
    Log.w(TAG, "processing: " + intent.toString())
    if (intent?.action == Intent.ACTION_SEND && "text/plain" == intent.type) {
      Log.i(TAG, "received a SEND/text intent, checking for data...")
      intent.getStringExtra(Intent.EXTRA_TEXT)?.let {
        Log.i(TAG, "got data, converting intent to frigoligo protocol...")
        val target = "frigoligo://x/save?url=" + URLEncoder.encode(it, "utf-8")
        startActivity(Intent(Intent.ACTION_VIEW, Uri.parse(target)))
      }
    }
  }

}
