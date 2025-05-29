package cordova.plugin.vpndetection;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.os.Build;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;

import org.json.JSONArray;
import org.json.JSONException;

public class VPNDetection extends CordovaPlugin {

    private Context context;

    @Override
    protected void pluginInitialize() {
        // Ensure context is set early in lifecycle
        this.context = this.cordova.getContext();
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("isVPNConnected".equals(action)) {
            this.cordova.getThreadPool().execute(() -> {
                boolean isVpn = isVPNConnected();
                callbackContext.success(isVpn ? 1 : 0);
            });
            return true;
        }
        return false;
    }

    private boolean isVPNConnected() {
        ConnectivityManager cm = (ConnectivityManager) context.getSystemService(Context.CONNECTIVITY_SERVICE);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            Network activeNetwork = cm.getActiveNetwork();
            if (activeNetwork != null) {
                NetworkCapabilities caps = cm.getNetworkCapabilities(activeNetwork);
                return caps != null && caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN);
            }
        }
        return false;
    }
}