import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class DataProductModel {
  dynamic productId;
  String productImage;
  dynamic productPrice;
  String productDescription;
  String productName;
  String productState;
  DataProductModel({
    this.productId = 0,
    this.productImage = 'assets/images/medicine.png',
    this.productPrice = 00,
    this.productName = 'Name Product',
    this.productState = 'state av',
    this.productDescription = "There are many fake or unproven medical products and"
        " methods that claim to diagnose, prevent or cure COVID-19.[1] "
        "Fake medicines sold for COVID-19 may not contain the ingredients"
        "they claim to contain, and may even contain harmful ingredients.[2][1][3]"
        " In March 2020, the World Health Organization (WHO)"
        " released a statement recommending against taking any",
  });
}
class TestSearch extends StatefulWidget {
  const TestSearch({Key? key}) : super(key: key);

  @override
  _TestSearchState createState() => _TestSearchState();
}
class _TestSearchState extends State<TestSearch> {
  // This holds a list of products fetched from the API
  List<DataProductModel> _allProducts = [];
  // This list holds the data for the list view
  List<DataProductModel> _foundProducts = [];
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }
  Future<void> fetchProducts() async {
    // Fetch products from an API or a database
    final response =
      await http.get(Uri.parse('http://185.132.55.54:8000/products/'));
    final jsonData = json.decode(response.body);
    // Map the product data to a list of DataProductModel objects
    _allProducts = jsonData
        .map<DataProductModel>((product) => DataProductModel(
              productId: product["product_id"],
              productName: product["pro_name"],
              productPrice: product["price"],
              productDescription: product["description"],
              productImage: product["image"],
            ))
        .toList();
    // Set the initial state of the found products to show all products
    setState(() {
      _foundProducts = _allProducts;
    });
  }
  void _runFilter(String enteredKeyword) {
    List<DataProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all products
      results = _allProducts;
    } else {
      results = _allProducts
          .where((product) => product.productName
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    // Refresh the UI
    setState(() {
      _foundProducts = results;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Products'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search',
                   suffixIcon: Icon(Icons.search),
                   ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundProducts.isNotEmpty ? ListView.builder(
                      itemCount: _foundProducts.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundProducts[index].productId),
                        color: Colors.amberAccent,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          title: Text(_foundProducts[index].productName),
                          subtitle: Text(
                              'Price: ${_foundProducts[index].productPrice.toString()}'),
                          trailing: Image.network(_foundProducts[index].productImage)
                        ),
                      ),
                    )
                  : const Center(
                      child: Text('No products found'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}








