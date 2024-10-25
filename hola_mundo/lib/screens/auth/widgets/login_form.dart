// lib/screens/auth/widgets/login_form.dart

import 'package:flutter/material.dart';
import 'package:hola_mundo/screens/auth/widgets/custom_button.dart';
import 'package:hola_mundo/screens/auth/widgets/custom_text_field.dart';

class LoginForm extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          labelText: 'Correo electrónico',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        CustomTextField(
          labelText: 'Contraseña',
          controller: passwordController,
          obscureText: true, // Se utiliza `obscureText` para ocultar la contraseña
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Iniciar sesión',
          onPressed: () {
            // Lógica para manejar el login
          },
        ),
      ],
    );
  }
}
