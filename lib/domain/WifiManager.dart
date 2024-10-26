import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/share_preference/SharePreference.dart';
import '../util/const.dart';
import 'PlayController.dart';

class WifiManager {
  ConnectivityResult _result = ConnectivityResult.none;
  bool _isNeedWifi = false;

  WifiManager._();

  //第一种方式调用
  factory WifiManager() {
    return instance;
  }

  //第二种方式调用
  static WifiManager instance = WifiManager._();

  void init() async {
    _isNeedWifi = await fetchAppSettingWifiCompulsion();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) async {
      _result = results.first;
      _isNeedWifi = await fetchAppSettingWifiCompulsion();
      if (_result == ConnectivityResult.mobile && _isNeedWifi) {
        PlayController.instance.pause();
      }
    });
  }

  void setIsNeedWifi(bool isNeedWifi) {
    _isNeedWifi = isNeedWifi;

    if (WifiManager.instance.isNeedConnectWithWifi) {
      PlayController.instance.pause();
    }
    saveAppSettingWifiCompulsion(isNeedWifi);
  }

  bool get isNeedConnectWithWifi {
    return _result == ConnectivityResult.mobile && _isNeedWifi;
  }
}
