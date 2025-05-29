package cordova.plugin.vpndetection;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;

public class VpnDetection extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
        if ("isVPNConnected".equals(action)) {
            boolean isVpn = isVPNConnected();
            callbackContext.success(isVpn ? 1 : 0);
            return true;
        }
        return false;
    }

    private boolean isVPNConnected() {
        ConnectivityManager cm = (ConnectivityManager) cordova.getActivity().getSystemService(Context.CONNECTIVITY_SERVICE);
        if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.M) {
            Network activeNetwork = cm.getActiveNetwork();
            if (activeNetwork != null) {
                NetworkCapabilities caps = cm.getNetworkCapabilities(activeNetwork);
                return caps != null && caps.hasTransport(NetworkCapabilities.TRANSPORT_VPN);
            }
        }
        return false;
    }
}
