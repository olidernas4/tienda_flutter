import 'package:flutter/material.dart';
import 'providers/auth_provider.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import './screens/product_list_screen.dart'; // Importa la pantalla de lista de productos product_list_screen
import './screens/product_detail_screen.dart'; // Importa la pantalla de detalles de  product_detail_screen
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Auth App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/products': (context) => ProductListScreen(), // Ruta para la lista de productos
          '/product_details': (context) => ProductDetailScreen(productId: 1), // Ruta para los detalles del producto (solo como ejemplo)
        },
      ),
    );
  }
}
