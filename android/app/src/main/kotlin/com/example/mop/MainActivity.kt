package com.example.mop

import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.BasicMessageChannel
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StringCodec
import io.flutter.plugins.GeneratedPluginRegistrant
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext


class MainActivity : FlutterActivity() {

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)


        val channel = BasicMessageChannel<String>(flutterEngine.dartExecutor, "myMessageChannel",
            StringCodec.INSTANCE
        )
        channel.setMessageHandler { message, reply ->
            Log.d("msg", "Received: $message")
            reply.reply("Reply from Android for First page")
            channel.send("Hello from Android for First page") { replay ->
                Log.d("msg", "Reply: $replay")
            }
        }

        val methodChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "myMethodChannel")
        methodChannel.setMethodCallHandler { call, result ->
            if (call.method == "oneMethod") {
                val arguments = call.arguments as Map<String, String>
                val username = arguments["username"]
                val password = arguments["password"]

                Log.d("MethodChannel", "Username: $username, Password: $password")

                // 로그인 검증 로직
                if (username == "admin" && password == "1234") {
                    result.success(
                        mapOf(
                            "status" to "success",
                        )
                    )
                } else {
                    result.success(
                        mapOf(
                            "status" to "failure",
                        )
                    )
                }
                methodChannel.invokeMethod("twoMethod", "Hello from Android for Second Page", object : MethodChannel.Result {
                    override fun success(result: Any?) {
                        Log.d("MethodChannel", "Success: ${result as String}")
                    }

                    override fun error(errorCode: String, errorMessage: String?, errorDetails: Any?) {
                        Log.e("MethodChannel", "Error: $errorCode, $errorMessage")
                    }

                    override fun notImplemented() {
                        Log.w("MethodChannel", "Method not implemented")
                    }
                })
            } else {
                result.notImplemented()
            }
        }

        val eventChannel = EventChannel(flutterEngine.dartExecutor, "eventChannel")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            private var job: Job? = null
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                job = CoroutineScope(Dispatchers.Default).launch{
                    try{
                        var count =0;
                        while (true){
                            delay(1000)
                            count++
                            withContext(Dispatchers.Main){
                                events?.success("Stream Count: ${count}")
                            }
                        }
                    } catch (e:Exception){
                        withContext(Dispatchers.Main){
                            events?.error("ERROR", "Stream Error", e.message)
                        }
                    }
                }
            }

            override fun onCancel(arguments: Any?) {
                job?.cancel()
            }
        })
    }


}
