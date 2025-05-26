var exec = require('cordova/exec');

exports.isVpnEnabled = function (success, error) {
    exec(success, error, 'VpnDetection', 'isVpnEnabled', []);
};
