package com.perdev.screen_light

import android.app.Activity
import android.content.Context
import android.database.ContentObserver
import android.os.Handler
import android.provider.Settings
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import java.util.*


/** ScreenLightPlugin */
class ScreenLightPlugin : FlutterPlugin, ActivityAware, MethodChannel.MethodCallHandler {
    
    ///唯一通道名
    private val _channelName = "payne/perdev/screen_light"
    
    ///方法名
    private val _getSysScreenLight = "getSysScreenLight"
    private val _listenSysScreenLight = "listenSysScreenLight"
    private val _unlistenSysScreenLight = "unlistenSysScreenLight"
    private val _setAppScreenLight = "setAppScreenLight"
    private val _getAppScreenLight = "getAppScreenLight"
    
    ///参数名
    private val _argLight = "argLight"
    private val _argSelfChange = "argSelfChange"
    
    ///回调方法名
    private val _callbackSysScreenLightChanged = "callbackSysScreenLightChanged"
    
    private lateinit var channel: MethodChannel
    private lateinit var context: Context
    private lateinit var activity: Activity
    private var listening = false
    
    private val contentObserver: ContentObserver = object : ContentObserver(Handler()) {
        override fun onChange(selfChange: Boolean) {
            val light = getSysScreenLight()
//                    Log.d("slptag", "onChange: selfChange=$selfChange  light=$light")
            
            channel.invokeMethod(_callbackSysScreenLightChanged,
                    argumentsMap(_argLight, light, _argSelfChange, selfChange))
        }
    }
    
    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, _channelName)
        channel.setMethodCallHandler(this)
    }
    
    ///flutter通过_channel.invokeMethod调用方法后，会走到此处
    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        when (call.method) {
            _getSysScreenLight -> callGetSysScreenLight(call, result)
            _setAppScreenLight -> callSetAppScreenLight(call, result)
            _getAppScreenLight -> callGetAppScreenLight(call, result)
            _listenSysScreenLight -> callListenSysScreenLight(call, result)
            _unlistenSysScreenLight -> callUnlistenSysScreenLight(call, result)
        }
    }
    
    private fun getSysScreenLight(): Int {
        val contentResolver = context.contentResolver
        return Settings.System.getInt(contentResolver, Settings.System.SCREEN_BRIGHTNESS, 125)
    }
    
    private fun argumentsMap(vararg args: Any): Map<String, Any> {
        val arguments: MutableMap<String, Any> = HashMap()
        var i = 0
        while (i < args.size) {
            arguments[args[i].toString()] = args[i + 1]
            i += 2
        }
        return arguments
    }
    
    private fun callGetSysScreenLight(call: MethodCall, result: Result) {
        try {
            val light = getSysScreenLight()
            result.success(light)
        } catch (e: Exception) {
            result.error("e=$e", "", "")
        }
    }
    
    
    private fun callListenSysScreenLight(call: MethodCall, result: Result) {
        try {
            if (listening) {
                result.success(true)
                return
            }
            listening = true
            val contentResolver = context.contentResolver
            contentResolver.registerContentObserver(
                    Settings.System.getUriFor(Settings.System.SCREEN_BRIGHTNESS),
                    true, contentObserver)
            result.success(true)
        } catch (e: Exception) {
            result.error("e=$e", "", "")
        }
    }
    
    private fun callUnlistenSysScreenLight(call: MethodCall, result: Result) {
        try {
            if (!listening) {
                result.success(true)
                return
            }
            listening = false
            val contentResolver = context.contentResolver
            contentResolver.unregisterContentObserver(contentObserver)
            result.success(true)
        } catch (e: Exception) {
            result.error("e=$e", "", "")
        }
    }
    
    private fun callGetAppScreenLight(call: MethodCall, result: Result) {
        try {
            val light = activity.window.attributes.screenBrightness * 255
            result.success(light.toInt())
        } catch (e: Exception) {
            result.error("e=$e", "", "")
        }
    }
    
    private fun callSetAppScreenLight(call: MethodCall, result: Result) {
        try {
            val light: Int? = call.argument<Int>(_argLight)
            val lp = activity.window.attributes
            lp.screenBrightness = light!! / 255.0f
            activity.window.attributes = lp
            result.success(true)
        } catch (e: Exception) {
            result.error("e=$e", "", "")
        }
    }
    
    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
    
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }
    
    override fun onDetachedFromActivityForConfigChanges() {
    
    }
    
    override fun onReattachedToActivityForConfigChanges(p0: ActivityPluginBinding) {
    }
    
    override fun onDetachedFromActivity() {
    }
}
