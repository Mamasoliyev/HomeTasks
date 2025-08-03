package com.example.yandex_map

import android.app.Application

import com.yandex.mapkit.MapKitFactory

class MainApplication: Application() {
  override fun onCreate() {
    super.onCreate()
    MapKitFactory.setLocale("en_US") // Your preferred language. Not required, defaults to system language
    MapKitFactory.setApiKey("4ef45cb7-8b22-4475-a03d-a310d3e8013c") // Your generated API key
  }
}
