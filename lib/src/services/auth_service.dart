import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  static const String _url = 'identitytoolkit.googleapis.com';
  final storage = const FlutterSecureStorage();

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };
    final uri = Uri.https(
      _url,
      '/v1/accounts:signInWithPassword',
    );
    final resp = await http.post(uri, body: json.encode(authData));
    final Map<String, dynamic> decodeResp = json.decode(resp.body);
    if (decodeResp.containsKey('status')) {
      await storage.write(key: 'email', value: decodeResp['email']);
      return null;
    } else {
      return "Sucedio un error no es posible iniciar sesión";
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
