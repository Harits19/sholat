package com.example.sholat

import android.app.Activity
import android.os.Bundle
import android.view.WindowManager
import android.widget.Button
import android.widget.TextView

class AlarmActivity : Activity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        window.addFlags(
            WindowManager.LayoutParams.FLAG_SHOW_WHEN_LOCKED or
            WindowManager.LayoutParams.FLAG_TURN_SCREEN_ON or
            WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON
        )

        val textView = TextView(this).apply {
            text = "Waktunya Sholat!"
            textSize = 24f
            setPadding(50, 200, 50, 50)
        }

        val dismissButton = Button(this).apply {
            text = "Tutup"
            setOnClickListener { finish() }
        }

        val layout = android.widget.LinearLayout(this).apply {
            orientation = android.widget.LinearLayout.VERTICAL
            addView(textView)
            addView(dismissButton)
        }

        setContentView(layout)
    }
}
