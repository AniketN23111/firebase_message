import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

class FirebaseRemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initializeRemoteConfig() async {
    try {
      // Set configuration settings for Remote Config
      await _remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout:
            const Duration(minutes: 1), // Timeout duration for fetch requests
        minimumFetchInterval: const Duration(hours: 1), // Fetch interval
      ));

      // Set default values for Remote Config
      await _remoteConfig.setDefaults(
        const {"name": "Hello, world!", "Title": "Default Title"},
      );

      // Fetch the latest values from Remote Config and activate them
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      // Handle exceptions such as network issues
      debugPrint('Remote Config fetch failed: $e');
    }
  }

  // Retrieve the value for a given key from Remote Config
  String getRemoteConfigValue(String key) {
    try {
      return _remoteConfig.getString(key);
    } catch (e) {
      debugPrint('Error getting Remote Config value for $key: $e');
      return 'N/A'; // Return a fallback value in case of an error
    }
  }
}
