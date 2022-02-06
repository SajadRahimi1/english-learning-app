package com.ir.zabaner

 import io.flutter.app.FlutterApplication
 import io.flutter.plugin.common.PluginRegistry
 import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
 import io.flutter.plugins.GeneratedPluginRegistrant
 import android.content.Context          
 import androidx.multidex.MultiDex

class MyApp : FlutterApplication(), PluginRegistrantCallback {

    override fun attachBaseContext(base: Context) {
        super.attachBaseContext(base)        
        MultiDex.install(this)
    }

    override fun onCreate() {
      super.onCreate()

      // other codes

    }

    override fun registerWith(registry: PluginRegistry) {
    }
}