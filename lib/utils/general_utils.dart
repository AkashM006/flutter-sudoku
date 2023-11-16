import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

void encodeAndPersist(SharedPreferences sp, String key, dynamic value) {
  sp.setString(key, jsonEncode(value));
}

