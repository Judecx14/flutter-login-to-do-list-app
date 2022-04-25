import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static const String _url = '192.168.0.7:8000';
  final storage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final uri = Uri.parse('http://192.168.0.7:8000/api/v1/login-mobile');
    //TODO cuando este el https en server
    /* final uri = Uri.https(
      _url,
      '/api/v1/login-mobile',
    ); */
    final resp = await http.post(uri, body: authData);
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    if (decodeResp['status'] == true) {
      await storage.write(key: 'email', value: decodeResp['email']);
      return null;
    } else {
      return decodeResp['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'email');
    return;
  }

  Future<String> readEmail() async {
    return await storage.read(key: 'email') ?? '';
  }
}
