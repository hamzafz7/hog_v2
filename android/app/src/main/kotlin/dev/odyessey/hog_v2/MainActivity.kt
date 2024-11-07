package dev.odyessey.hog_v2

import android.os.DeadObjectException
import android.util.Log
import android.view.inputmethod.InputMethodManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private lateinit var imm: InputMethodManager
    private val CHANNEL = "keyboard_channel"
    private var isKeyboardVisible = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        imm = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager

        setupMethodChannel(flutterEngine)
    }

    private fun handleKeyboardOperations(
        operation: String,
        action: (InputMethodManager) -> Unit,
        onError: (() -> Unit)? = null
    ) {
        try {
            action(imm)
            Log.d("KeyboardOperation", "$operation successful")
        } catch (e: DeadObjectException) {
            Log.e("KeyboardOperation", "$operation failed with DeadObjectException", e)

            try {
                // Recovery attempt
                imm = getSystemService(INPUT_METHOD_SERVICE) as InputMethodManager
                action(imm)
                Log.d("KeyboardOperation", "$operation recovered successfully")
            } catch (e: Exception) {
                Log.e("KeyboardOperation", "$operation recovery failed", e)
                onError?.invoke()
            }
        } catch (e: Exception) {
            Log.e("KeyboardOperation", "$operation failed with unknown error", e)
            onError?.invoke()
        }
    }

    private fun showKeyboard(result: MethodChannel.Result) {
        handleKeyboardOperations(
            "Show Keyboard",
            { imm ->
                val view = currentFocus
                if (view != null) {
                    imm.showSoftInput(view, InputMethodManager.SHOW_IMPLICIT)
                    Log.i("Show", "Show Keyboard successful")
                    result.success(true)
                } else {
                    Log.i("Show", "Show Keyboard failed")
                    result.success(false)
                }
            },
            { result.error("KEYBOARD_ERROR", "Failed to show keyboard", null) }
        )
    }

    private fun hideKeyboard(result: MethodChannel.Result) {
        handleKeyboardOperations(
            "Hide Keyboard",
            { imm ->
                val view = currentFocus
                if (view != null) {
                    imm.hideSoftInputFromWindow(view.windowToken, 0)
                    Log.i("Hide", "Hide Keyboard successful")
                    result.success(true)
                } else {
                    Log.i("Hide", "Hide Keyboard failed")
                    result.success(false)
                }
            },
            { result.error("KEYBOARD_ERROR", "Failed to hide keyboard", null) }
        )
    }

    override fun onStart() {
        super.onStart()
        val rootView = window.decorView.rootView
        rootView.viewTreeObserver.addOnGlobalLayoutListener {
            val rect = android.graphics.Rect()
            rootView.getWindowVisibleDisplayFrame(rect)
            val screenHeight = rootView.height
            val keypadHeight = screenHeight - rect.bottom
            isKeyboardVisible = keypadHeight > 200
        }
    }

    private fun isKeyboardVisible(result: MethodChannel.Result) {
        handleKeyboardOperations(
            "Is Keyboard Visible",
            { imm ->
                val view = currentFocus
                if (view != null) {
                    Log.i("Visible", "Visible Keyboard: $isKeyboardVisible")
                    result.success(isKeyboardVisible)
                } else {
                    Log.i("Visible", "Check Keyboard State Failed")
                    result.success(null)
                }
            },
            { result.error("KEYBOARD_ERROR", "Failed to check keyboard state", null) }
        )
    }

    private fun setupMethodChannel(flutterEngine: FlutterEngine) {
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "showKeyboard" -> showKeyboard(result)
                    "hideKeyboard" -> hideKeyboard(result)
                    "isKeyboardVisible" -> isKeyboardVisible(result)
                    else -> result.notImplemented()
                }
            }
    }
}