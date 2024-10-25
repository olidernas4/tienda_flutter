// lib/screens/auth/widgets/register_form.dart

import 'package:flutter/material.dart';
import 'package:hola_mundo/screens/auth/widgets/custom_button.dart';
import 'package:hola_mundo/screens/auth/widgets/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomTextField(
          labelText: 'Email',
          controller: emailController,
        ),
        const SizedBox(height: 20),
        CustomTextField(
          labelText: 'Password',
          controller: passwordController,
          obscureText: true, // Usar obscureText en lugar de isPassword
        ),
        const SizedBox(height: 20),
        CustomTextField(
          labelText: 'Confirm Password',
          controller: confirmPasswordController,
          obscureText: true, // Usar obscureText para el campo de confirmación
        ),
        const SizedBox(height: 20),
        CustomButton(
          text: 'Register', // Cambié `buttonText` a `text` porque es así como se definió en el botón
          onPressed: () {
            // Lógica para registrar usuario
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
        ),
      ],
    );
  }
}
