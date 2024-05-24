import 'dart:convert';

import 'package:flutter_mobile_app/model/cache_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin CacheData {
  Future getCacheData(String url) async {
    final pref = await SharedPreferences.getInstance();
    final data = pref.getString(url);
    if (data != null) {
      final jsonModel = jsonDecode(data);
      final cacheModel = CachModel.fromJson(jsonModel);
      if (DateTime.now().isBefore(DateTime.parse(cacheModel.time))) {
        return CachModel.fromJson(jsonModel).body;
      } else {
        await removeCache(url);
      }
    }
    return null;
  }

  Future<bool> saveCacheData(
      dynamic body, String url, Duration duration) async {
    final pref = await SharedPreferences.getInstance();
    CachModel local = CachModel(
        body: body, time: DateTime.now().add(duration).toIso8601String());
    final json = jsonEncode(local.toJson());
    if (body != null && json.isNotEmpty) {
      return await pref.setString(url, json);
    }
    return false;
  }

  Future<bool> removeCache(String url) async {
    final pref = await SharedPreferences.getInstance();
    return await pref.remove(url);
  }

  Future<bool> removeAllCacheInCategory(String category) async {
    final pref = await SharedPreferences.getInstance();
    var keys = pref.getKeys().where((element) => element.contains(category));
    for (var key in keys) {
      await pref.remove(key);
    }
    return true;
  }

  Future<bool> clearCache() async {
    final pref = await SharedPreferences.getInstance();
    return await pref.clear();
  }
}
