/*
 * Copyright (C) 2021-2022 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.doze

import android.app.Service
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.content.SharedPreferences
import android.database.ContentObserver
import android.net.Uri
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.os.PowerManager
import android.provider.Settings
import android.util.Log
import androidx.preference.PreferenceManager

class DozeService : Service() {
    private lateinit var pickupSensor: PickupSensor
    private lateinit var pocketSensor: PocketSensor
    private var settingsObserver: ContentObserver? = null

    private val screenStateReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context, intent: Intent) {
            when (intent.action) {
                Intent.ACTION_SCREEN_ON -> onDisplayOn()
                Intent.ACTION_SCREEN_OFF -> onDisplayOff()
            }
        }
    }

    private val prefListener = SharedPreferences.OnSharedPreferenceChangeListener { _, _ ->
        updateSensors()
    }

    override fun onCreate() {
        Log.d(TAG, "Creating service")
        pickupSensor = PickupSensor(
            this,
            resources.getString(R.string.pickup_sensor_type),
            resources.getFloat(R.dimen.pickup_sensor_value),
        )
        pocketSensor = PocketSensor(
            this,
            resources.getString(R.string.pocket_sensor_type),
            resources.getFloat(R.dimen.pocket_sensor_value)
        )

        val screenStateFilter = IntentFilter().apply {
            addAction(Intent.ACTION_SCREEN_ON)
            addAction(Intent.ACTION_SCREEN_OFF)
        }
        registerReceiver(screenStateReceiver, screenStateFilter)

        registerSettingsObserver()
        PreferenceManager.getDefaultSharedPreferences(this)
            .registerOnSharedPreferenceChangeListener(prefListener)
    }

    private fun registerSettingsObserver() {
        settingsObserver = object : ContentObserver(Handler(Looper.getMainLooper())) {
            override fun onChange(selfChange: Boolean, uri: Uri?) {
                updateSensors()
            }
        }
        val resolver = contentResolver
        val uris = listOf(
            Settings.Secure.getUriFor(Settings.Secure.DOZE_PICK_UP_GESTURE),
            Settings.Secure.getUriFor(Utils.DOZE_PICK_UP_GESTURE_AMBIENT),
            Settings.Secure.getUriFor(Settings.Secure.DOZE_ENABLED),
            Settings.Secure.getUriFor(Settings.Secure.DOZE_ALWAYS_ON),
            Settings.System.getUriFor(Utils.POCKET_JUDGE)
        )
        for (uri in uris) {
            resolver.registerContentObserver(uri, false, settingsObserver!!)
        }
    }

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        updateSensors()
        return START_STICKY
    }

    override fun onDestroy() {
        super.onDestroy()
        unregisterReceiver(screenStateReceiver)
        settingsObserver?.let { contentResolver.unregisterContentObserver(it) }
        PreferenceManager.getDefaultSharedPreferences(this)
            .unregisterOnSharedPreferenceChangeListener(prefListener)
        pickupSensor.disable()
        pocketSensor.disable()
    }

    override fun onBind(intent: Intent?): IBinder? = null

    private fun onDisplayOn() {
        pickupSensor.disable()
        pocketSensor.disable()
    }

    private fun onDisplayOff() {
        val dozeEnabled = Utils.isDozeEnabled(this)
        val aodEnabled = Utils.isAlwaysOnEnabled(this)
        val pickUpEnabled = Utils.isPickUpEnabled(this)
        val pickUpSetToWake = Utils.isPickUpSetToWake(this)

        if (dozeEnabled && pickUpEnabled && (!aodEnabled || pickUpSetToWake)) {
            pickupSensor.enable()
        } else {
            pickupSensor.disable()
        }

        if (Utils.isPocketEnabled(this)) {
            pocketSensor.enable()
        } else {
            pocketSensor.disable()
        }
    }

    private fun updateSensors() {
        val powerManager = getSystemService(PowerManager::class.java)
        if (powerManager != null && !powerManager.isInteractive) {
            onDisplayOff()
        } else {
            onDisplayOn()
        }
    }

    companion object {
        private const val TAG = "DozeService"
    }
}
