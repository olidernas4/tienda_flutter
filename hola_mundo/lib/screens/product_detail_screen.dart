import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  final int productId;

  ProductDetailScreen({required this.productId});

  Map<String, dynamic> getProductDetails(int id) {
    
    return {
      'name': 'Producto Ejemplo',
      'description': 'Descripción del producto ejemplo.',
      'price': 99.99,
    };
  }

  @override
  Widget build(BuildContext context) {
    final productDetails = getProductDetails(productId);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles del Producto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Nombre: ${productDetails['name']}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Descripción: ${productDetails['description']}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Precio: \$${productDetails['price']}",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}