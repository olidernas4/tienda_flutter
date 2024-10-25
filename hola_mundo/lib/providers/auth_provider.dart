import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  final ApiService _apiService = ApiService();

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      final response = await _apiService.login(email, password);
      _token = response['access_token']; // Guardamos el token
      _user = await getUserProfile(); // Obtenemos la información del usuario con el token
      notifyListeners();
      
      
      Navigator.pushReplacementNamed(context, '/products');
    } catch (e) {
      print('Error al iniciar sesión: $e');
      throw Exception('Login failed');
    }
  }

  Future<void> register(String email, String password) async {
    try {
      await _apiService.register(email, password);
      // Registro exitoso
      notifyListeners();
    } catch (e) {
      print('Error al registrarse: $e');
      throw Exception('Register failed');
    }
  }

  Future<User?> getUserProfile() async {
    try {
      if (_token != null) {
        final response = await _apiService.getUserProfile(_token!);
        _user = User.fromJson(response); 
        return _user;
      }
    } catch (e) {
      print('Error al obtener perfil de usuario: $e');
    }
    return null;
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}

