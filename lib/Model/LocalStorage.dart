// import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  Future<void> getUserGuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final guid = prefs.getString('guid_id');
      return guid;
    } catch (e) {
      return null;
    }
  }
}
