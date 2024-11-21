package com.example.dynamic_icon_app

import android.content.ComponentName
import android.content.pm.PackageManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.dynamic_icon_app/icon"

     override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "switchAppIcon" -> {
                    val isChristmas = call.argument<Boolean>("isChristmas") ?: false
                    switchAppIcon(isChristmas)
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun switchAppIcon(isChristmas: Boolean) {
        try {
            val packageManager = applicationContext.packageManager
    
            // ปิดไอคอนเริ่มต้น
            packageManager.setComponentEnabledSetting(
                ComponentName(applicationContext, "com.example.dynamic_icon_app.MainActivityDefault"),
                if (isChristmas) PackageManager.COMPONENT_ENABLED_STATE_DISABLED else PackageManager.COMPONENT_ENABLED_STATE_ENABLED,
                PackageManager.DONT_KILL_APP
            )
    
            // เปิดไอคอนเทศกาล
            packageManager.setComponentEnabledSetting(
                ComponentName(applicationContext, "com.example.dynamic_icon_app.MainActivityChristmas"),
                if (isChristmas) PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED,
                PackageManager.DONT_KILL_APP
            )
            val intent = Intent(Intent.ACTION_MAIN).apply {
                addCategory(Intent.CATEGORY_HOME)
                flags = Intent.FLAG_ACTIVITY_NEW_TASK
            }
            startActivity(intent)
        } catch (e: Exception) {
            e.printStackTrace() // แสดงข้อผิดพลาดใน Logcat
        }
    }
}
