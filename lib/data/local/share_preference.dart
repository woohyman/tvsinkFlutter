import 'package:shared_preferences/shared_preferences.dart';

//是否是Vip
const String keyIsVip = "keyIsVip";

//是否自动切换播放源
const String keyAutoSourceSwitch = "keyAutoSourceSwitch";

//是否强制Wifi下才能播放
const String keyWifiSetting = "keyWifiSetting";

//是否允许后台播放
const String keyAllowBkgPlay = "keyAllowBkgPlay";

Future<void> saveAppSetting(String key, bool _state) async {
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  _preferences.setBool(key, _state);
}

Future<bool> fetchAppSetting(String key) async {
  SharedPreferences _preferences = await SharedPreferences.getInstance();
  return _preferences.getBool(key) ?? false;
}
