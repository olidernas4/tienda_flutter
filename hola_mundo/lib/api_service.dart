import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {

  // Método para registrar un nuevo usuario
  Future<Map<String, dynamic>> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/register'), // URL completa especificada
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error en el registro: ${response.statusCode}');
    }
  }

  // Método para iniciar sesión y obtener el token
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/token'), // URL completa especificada
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'username': email,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Retorna el token
    } else {
      throw Exception('Error en el login: ${response.statusCode}');
    }
  }

  // Método para obtener el usuario autenticado utilizando el token
  Future<Map<String, dynamic>> getUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/users/me'), // URL completa especificada
      headers: {
        'Authorization': 'Bearer $token', // Pasamos el token en los headers
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al obtener el perfil del usuario: ${response.statusCode}');
    }
  }
}
