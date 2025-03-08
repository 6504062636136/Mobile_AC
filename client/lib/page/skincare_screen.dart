import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'skincare_detail_screen.dart';

class SkincareScreen extends StatefulWidget {
  @override
  _SkincareScreenState createState() => _SkincareScreenState();
}

class _SkincareScreenState extends State<SkincareScreen> {
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    final String apiUrl = "http://localhost:5001/api/skincare";

    try {
      final response = await http.get(Uri.parse(apiUrl)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        if (response.headers['content-type']?.contains('application/json') == true) {
          final List<dynamic> jsonData = json.decode(response.body);
          setState(() {
            _products = jsonData;
            _isLoading = false;
          });
        } else {
          print('❌ Error: Content-Type is not application/json');
          setState(() {
            _isLoading = false;
          });
        }
      } else {
        print('❌ Error: HTTP status code ${response.statusCode}');
        print('Response body: ${response.body}');
        setState(() {
          _isLoading = false;
        });
      }
    } on TimeoutException catch (e) {
      print('❌ Error: Timeout - $e');
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error fetching data: ${e.toString()}');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Skincare',
          style: TextStyle(fontFamily: 'Arial', fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.lightBlue[100],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.lightBlue),
        ),
      )
          : GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];

          String imageUrl = product['image'] ?? '';
          String productName = product['name'] ?? 'Unknown Name';
          double price = (product['price'] as num?)?.toDouble() ?? 0.0;
          dynamic productId = product['_id'];

          return GestureDetector(
            onTap: () {
              if (productId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SkincareDetailScreen(id: productId.toString()),
                  ),
                );
              } else {
                print('❌ Error: productId is null');
              }
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: imageUrl.isNotEmpty
                        ? Image.network(
                      imageUrl,
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 150,
                        height: 150,
                        color: Colors.grey[200],
                        child: const Icon(Icons.error, size: 40, color: Colors.grey),
                      ),
                    )
                        : Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Arial',
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'B${price.toStringAsFixed(2)}',  // แก้ไขเป็น B แทน $
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[700],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
