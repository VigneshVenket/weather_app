
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static const String _temperatureUnitKey = 'temperature_unit';

  static String temperatureUnit ='C';

  static Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    temperatureUnit = prefs.getString(_temperatureUnitKey) ?? 'C';
  }

  static Future<void> setTemperatureUnit(String? value) async {
    final prefs = await SharedPreferences.getInstance();
    temperatureUnit = value!;
    await prefs.setString(_temperatureUnitKey, value);
  }

}
