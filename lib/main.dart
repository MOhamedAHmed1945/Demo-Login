import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_project_api/test_auth.dart';
import 'package:test_project_api/test_search.dart';

import 'login_test_screen.dart';
import 'register_test_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginTestScreen(),//RegisterTestScreen(),//LoginTestScreen(),//TestSearch(), //ProductListScreen(),// LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Product>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('title'),
      ),
      body: FutureBuilder<List<Product>>(
        future: _futureProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = products[index];
                return ListTile(
                  title: Text(product.proName),
                  subtitle: Text(product.price.toString()),
                  leading: Image.network(product.image),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load products'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future<List<Product>> fetchProducts() async {
    final response =
        await http.get(Uri.parse('http://185.132.55.54:8000/products'));
    if (response.statusCode == 200) {
      Iterable productsJson = json.decode(response.body);
      List<Product> products = productsJson
          .map((productJson) => Product.fromJson(productJson))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class Product {
  final int id;
  final String proCode;
  final String proName;
  final String expDate;
  final double price;
  final String description;
  final int stock;
  final int limt;
  final String image;
  final int managerId;
  Product({
    required this.id,
    required this.proCode,
    required this.proName,
    required this.expDate,
    required this.price,
    required this.description,
    required this.stock,
    required this.limt,
    required this.image,
    required this.managerId,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      proCode: json['pro_code'],
      proName: json['pro_name'],
      expDate: json['exp_date'],
      price: json['price'].toDouble(),
      description: json['description'],
      stock: json['stock'],
      limt: json['limt'],
      image: json['image'],
      managerId: json['manager_id'],
    );
  }
}
