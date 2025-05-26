var exec = require('cordova/exec');

exports.isVPNConnected = function (success, error) {
    exec(success, error, 'VPNDetection', 'isVPNConnected', []);
};
