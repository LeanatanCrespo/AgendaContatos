import 'package:flutter/material.dart';
import 'package:agenda_contatos/tlogin.dart';
import 'package:agenda_contatos/principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = prefs.getString('username');

  runApp(MaterialApp(
    home: username != null ? Principal() : LoginScreen(),
  ));
}
