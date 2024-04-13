import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import 'local_storage_interface.dart';

class LocalStorageService implements ILocalStorageService {
  SharedPreferences? _prefs;

  LocalStorageService._internal();

  factory LocalStorageService() => LocalStorageService._internal();

  Future<SharedPreferences?> get _initializePrefs async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  @override
  Future<void> clear() async {
    final pref = await _initializePrefs;
    pref?.clear();
  }

  @override
  Future<bool?> getBool(String key) async {
    final pref = await _initializePrefs;
    return pref?.getBool(key);
  }

  @override
  Future<int?> getInt(String key) async {
    final pref = await _initializePrefs;
    return pref?.getInt(key);
  }

  @override
  Future<double?> getDouble(String key) async {
    final pref = await _initializePrefs;
    return pref?.getDouble(key);
  }

  @override
  Future<String?> getString(String key) async {
    final pref = await _initializePrefs;
    return pref?.getString(key);
  }

  @override
  Future<void> setBool(String key, bool? value) async {
    final pref = await _initializePrefs;

    if (value == null) {
      pref?.remove(key);
      return;
    }

    pref?.setBool(key, value);
  }

  @override
  Future<void> setInt(String key, int? value) async {
    final pref = await _initializePrefs;

    if (value == null) {
      pref?.remove(key);
      return;
    }

    pref?.setInt(key, value);
  }

  @override
  Future<void> setDouble(String key, double? value) async {
    final pref = await _initializePrefs;

    if (value == null) {
      pref?.remove(key);
      return;
    }

    pref?.setDouble(key, value);
  }

  @override
  Future<void> setString(String key, String? value) async {
    final pref = await _initializePrefs;

    if (value == null) {
      pref?.remove(key);
      return;
    }

    pref?.setString(key, value);
  }

  @override
  Future<void> remove(String key) async {
    final pref = await _initializePrefs;
    pref?.remove(key);
  }

  @override
  Future<List<String>?> getStringList(String key) async {
    final pref = await _initializePrefs;
    return pref?.getStringList(key);
  }

  @override
  Future<void> setStringList(String key, List<String>? value) async {
    final pref = await _initializePrefs;

    if (value == null) {
      pref?.remove(key);
      return;
    }

    pref?.setStringList(key, value);
  }
}
