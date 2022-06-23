import 'package:mockup_gems/utils/preference.dart';

mixin Header on Pref {
  final String kAccept = "Accept";
  final String kAuthor = "authorization";
  final String kDevice = "deviceid";
  final String accept = "application/json";
  final String author = "Bearer ";

  Map<String, String> get _header {
    return {
      kAccept: accept,
      kAuthor: author,
      kDevice: "",
    };
  }

  Future<Map<String, String>> get header async {
    final v = _header;
    // final a = await uuid;
    final b = await token;
    // v[kDevice] = a;
    v[kAuthor] = author + b;

    return v;
  }
}
