package com.example.spent

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val appRetainChannel = "com.example.spent/app_retain"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, appRetainChannel).setMethodCallHandler {
            call, result ->
                if (call.method == "sendToBackground") {
                    moveTaskToBack(true)
                    result.success(null)
                }
        }
    }
}