import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import './product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<dynamic> _products = [];
  int _page = 0;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();
  String _searchQuery = "";
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMoreProducts();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
        _loadMoreProducts();
      }
    });
    _searchController.addListener(() {
      _onSearch(_searchController.text);
    });
  }

  Future<void> _loadMoreProducts() async {
    setState(() {
      _isLoading = true;
    });

    String url = 'http://127.0.0.1:8000/products?skip=${_page * 10}&limit=10';
    if (_searchQuery.isNotEmpty) {
      url += '&search=$_searchQuery';
    }

    final token = Provider.of<AuthProvider>(context, listen: false).token;
    final response = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      setState(() {
        _products.addAll(json.decode(response.body));
        _page++;
        _isLoading = false;
      });
    } else {
      throw Exception('Error al cargar productos');
    }
  }

  void _onSearch(String query) {
    setState(() {
      _searchQuery = query;
      _products.clear();
      _page = 0;
    });
    _loadMoreProducts();
  }

  Future<void> _createProduct(String name, String description, int brandId, int categoryId, double price, int rating) async {
    final token = Provider.of<AuthProvider>(context, listen: false).token;
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/products'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'name': name,
        'description': description,
        'brand_id': brandId,
        'category_id': categoryId,
        'price': price,
        'rating': rating,
      }),
    );

    if (response.statusCode == 201) {
      setState(() {
        _products.clear();
        _page = 0;
      });
      _loadMoreProducts();
    } else {
      throw Exception('Error al crear producto');
    }
  }

  void _showCreateProductDialog() {
    final TextEditingController _nameController = TextEditingController();
    final TextEditingController _descriptionController = TextEditingController();
    final TextEditingController _brandController = TextEditingController();
    final TextEditingController _categoryController = TextEditingController();
    final TextEditingController _priceController = TextEditingController();
    final TextEditingController _ratingController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Crear Producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                ),
                TextField(
                  controller: _brandController,
                  decoration: InputDecoration(labelText: 'ID de Marca'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'ID de Categoría'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _ratingController,
                  decoration: InputDecoration(labelText: 'Calificación'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                String name = _nameController.text;
                String description = _descriptionController.text;
                int? brandId = int.tryParse(_brandController.text);
                int? categoryId = int.tryParse(_categoryController.text);
                double? price = double.tryParse(_priceController.text);
                int? rating = int.tryParse(_ratingController.text);

                if (name.isNotEmpty && description.isNotEmpty && brandId != null && categoryId != null && price != null && rating != null) {
                  _createProduct(name, description, brandId, categoryId, price, rating);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Por favor, ingrese datos válidos')),
                  );
                }
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos"),
        backgroundColor: const Color.fromARGB(255, 3, 47, 165),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              width: 200,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Buscar...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.white),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showCreateProductDialog,
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _products.length + 1,
        itemBuilder: (context, index) {
          if (index == _products.length) {
            return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
          }
          final product = _products[index];
          return Center(
            child: Card(
              margin: EdgeInsets.all(8.0),
              elevation: 4,
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text('Precio: \$${product['price']}'),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product['rating'].toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.star, color: Colors.amber),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailScreen(productId: product['id']),
                                ),
                              );
                            },
                            child: Text('Detalles'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
