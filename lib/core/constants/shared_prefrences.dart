import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  final preferences = SharedPreferencesAsync();
  void saveLocation(Position? position) {
    preferences.setDouble('lat', position!.latitude);
    preferences.setDouble('lng', position.longitude);
  }
}
