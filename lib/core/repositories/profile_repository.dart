import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/profile_model.dart';

class ProfileRepository {
  SharedPreferences _prefs;
  ProfileModel _profile;

  // singleton
  ProfileRepository._internal();
  static ProfileRepository _instance = ProfileRepository._internal();
  factory ProfileRepository() => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _loadData();
  }

  ProfileModel getProfile() {
    return _profile;
  }

  Future<void> setProfile(ProfileModel profile) async {
    await _prefs.setString('profileData', json.encode(profile.toJson()));
    _profile = profile;
  }

  void _loadData() {
    final profileData = _prefs.getString('profileData');
    if (profileData != null) {
      _profile = ProfileModel.fromJson(json.decode(profileData));
    }
  }
}