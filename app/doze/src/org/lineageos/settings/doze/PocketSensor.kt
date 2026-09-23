/*
 * Copyright (C) 2021-2025 The LineageOS Project
 * SPDX-License-Identifier: Apache-2.0
 */

package org.lineageos.settings.doze

import android.content.Context
import android.hardware.Sensor
import android.hardware.SensorEvent
import android.hardware.SensorEventListener
import android.hardware.SensorManager
import android.os.SystemClock
import android.os.SystemProperties

import java.util.concurrent.Executors

class PocketSensor(
    private val context: Context, sensorType: String, private val sensorValue: Float
) : SensorEventListener {
    private val sensorManager = context.getSystemService(SensorManager::class.java)!!
    private val sensor = Utils.getSensor(sensorManager, sensorType)

    private val executorService = Executors.newSingleThreadExecutor()
    private var entryTimestamp = 0L
    private var wasInPocket = false
    private var isEnabled = false

    override fun onSensorChanged(event: SensorEvent) {
        val isNear = event.values[0] == sensorValue
        if (isNear) {
            wasInPocket = true
            SystemProperties.set("sys.touch.pocket_mode", "1")
        } else {
            SystemProperties.set("sys.touch.pocket_mode", "0")
            if (wasInPocket) {
                wasInPocket = false
                val delta = SystemClock.elapsedRealtime() - entryTimestamp
                if (delta >= MIN_PULSE_INTERVAL_MS) {
                    entryTimestamp = SystemClock.elapsedRealtime()
                    Utils.launchDozePulse(context)
                }
            }
        }
    }

    override fun onAccuracyChanged(sensor: Sensor, accuracy: Int) {}

    fun enable() {
        if (sensor != null && !isEnabled) {
            isEnabled = true
            executorService.submit {
                entryTimestamp = SystemClock.elapsedRealtime()
                sensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_NORMAL)
            }
        }
    }

    fun disable() {
        if (sensor != null && isEnabled) {
            isEnabled = false
            executorService.submit {
                sensorManager.unregisterListener(this, sensor)
                wasInPocket = false
                SystemProperties.set("sys.touch.pocket_mode", "0")
            }
        }
    }

    companion object {
        private const val MIN_PULSE_INTERVAL_MS = 2500L
    }
}
