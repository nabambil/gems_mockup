import 'package:mockup_gems/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil<T> {
  Future<SharedPreferences> get pref => SharedPreferences.getInstance();
  Future<String> _string(String k) => pref.then((v) => v.getString(k));
  Future<bool> _bool(String k) => pref.then((v) => v.getBool(k));
}

class Pref extends PreferencesUtil {
  get name => _string(kName);
  get token => _string(kToken);
  get id => _string(kID);
  // get uuid => _string(kUUID);
  get username => _string(kUsername);
  get role => _string(kRole);
}
