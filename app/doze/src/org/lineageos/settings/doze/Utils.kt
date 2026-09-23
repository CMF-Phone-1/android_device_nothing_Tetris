/*
 * Copyright (C) 2021-2024 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.doze

import android.content.Context
import android.content.Intent
import android.hardware.Sensor
import android.hardware.SensorManager
import android.hardware.display.AmbientDisplayConfiguration
import android.os.UserHandle
import android.provider.Settings
import android.provider.Settings.Secure.DOZE_ALWAYS_ON
import android.provider.Settings.Secure.DOZE_ENABLED
import android.util.Log
import androidx.preference.PreferenceManager

object Utils {
    private const val TAG = "DozeUtils"

    private const val DOZE_INTENT = "com.android.systemui.doze.pulse"

    const val ALWAYS_ON_DISPLAY = "always_on_display"
    const val DOZE_ENABLE = "doze_enable"

    const val CATEGORY_PICKUP_SENSOR = "pickup_sensor"
    const val CATEGORY_PROXIMITY_SENSOR = "proximity_sensor"

    const val GESTURE_PICK_UP_KEY = "gesture_pick_up_type"
    const val GESTURE_POCKET_KEY = "gesture_pocket"

    // VoltageOS / AOSP settings keys
    const val DOZE_PICK_UP_GESTURE_AMBIENT = "doze_pick_up_gesture_ambient"
    const val POCKET_JUDGE = "pocket_judge"

    fun startService(context: Context) {
        Log.d(TAG, "Starting service")
        try {
            context.startServiceAsUser(Intent(context, DozeService::class.java), UserHandle.CURRENT)
        } catch (e: Exception) {
            Log.e(TAG, "Failed to start DozeService", e)
        }
    }

    fun stopService(context: Context) {
        Log.d(TAG, "Stopping service")
        try {
            context.stopServiceAsUser(Intent(context, DozeService::class.java), UserHandle.CURRENT)
        } catch (e: Exception) {
            Log.e(TAG, "Failed to stop DozeService", e)
        }
    }

    fun checkDozeService(context: Context) {
        // Keep service running to allow ContentObservers to react to runtime setting toggles
        startService(context)
    }

    fun isDozeEnabled(context: Context): Boolean {
        return Settings.Secure.getInt(context.contentResolver, DOZE_ENABLED, 1) != 0
    }

    fun enableDoze(context: Context, enable: Boolean): Boolean {
        return Settings.Secure.putInt(context.contentResolver, DOZE_ENABLED, if (enable) 1 else 0)
    }

    fun launchDozePulse(context: Context) {
        Log.d(TAG, "Launch doze pulse")
        context.sendBroadcastAsUser(Intent(DOZE_INTENT), UserHandle(UserHandle.USER_CURRENT))
    }

    fun enableAlwaysOn(context: Context, enable: Boolean): Boolean {
        return Settings.Secure.putIntForUser(
            context.contentResolver, DOZE_ALWAYS_ON, if (enable) 1 else 0, UserHandle.USER_CURRENT
        )
    }

    fun isAlwaysOnEnabled(context: Context): Boolean {
        return Settings.Secure.getIntForUser(
            context.contentResolver, DOZE_ALWAYS_ON, 0, UserHandle.USER_CURRENT
        ) != 0
    }

    fun alwaysOnDisplayAvailable(context: Context): Boolean {
        return AmbientDisplayConfiguration(context).alwaysOnAvailable()
    }

    private fun isGestureEnabled(context: Context, gesture: String?): Boolean {
        return PreferenceManager.getDefaultSharedPreferences(context)
            .getBoolean(gesture, false)
    }

    fun isPickUpEnabled(context: Context): Boolean {
        val aospValue = Settings.Secure.getInt(
            context.contentResolver,
            Settings.Secure.DOZE_PICK_UP_GESTURE,
            -1
        )
        if (aospValue != -1) {
            return aospValue != 0
        }
        val pref = PreferenceManager.getDefaultSharedPreferences(context)
            .getString(GESTURE_PICK_UP_KEY, null)
        if (pref != null) {
            return pref != "0"
        }
        return try {
            context.resources.getBoolean(
                com.android.internal.R.bool.config_dozePickupGestureEnabled
            )
        } catch (e: Exception) {
            false
        }
    }

    fun isPickUpSetToWake(context: Context): Boolean {
        val aospValue = Settings.Secure.getInt(
            context.contentResolver,
            Settings.Secure.DOZE_PICK_UP_GESTURE,
            -1
        )
        if (aospValue != -1) {
            // VoltageOS: 0 = wake screen, 1 = ambient pulse
            val ambientOnly = Settings.Secure.getInt(
                context.contentResolver,
                DOZE_PICK_UP_GESTURE_AMBIENT,
                0
            ) != 0
            return !ambientOnly
        }

        // Lineage fallback: "2" = wake screen, "1" = ambient pulse
        return PreferenceManager.getDefaultSharedPreferences(context)
            .getString(GESTURE_PICK_UP_KEY, "0") == "2"
    }

    fun isPocketEnabled(context: Context): Boolean {
        val pocketVal = Settings.System.getInt(
            context.contentResolver,
            POCKET_JUDGE,
            -1
        )
        if (pocketVal != -1) {
            return pocketVal != 0
        }
        return isGestureEnabled(context, GESTURE_POCKET_KEY)
    }

    fun areGesturesEnabled(context: Context): Boolean {
        return isPickUpEnabled(context) || isPocketEnabled(context)
    }

    fun getSensor(sm: SensorManager, type: String?): Sensor? {
        return sm.getSensorList(Sensor.TYPE_ALL).find { it.stringType == type }
    }
}
