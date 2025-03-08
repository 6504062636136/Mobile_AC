import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailPage extends StatefulWidget {
  final String id; // รับค่า productId จากหน้าก่อนหน้า

  ProductDetailPage({required this.id});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  Map<String, dynamic>? product;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchBestSeller();
  }

  // ฟังก์ชันดึงข้อมูลสินค้าจาก API
  Future<void> fetchBestSeller() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.1.100:5002/api/bestseller'));

      if (response.statusCode == 200) {
        List<dynamic> products = json.decode(response.body); // ดึงข้อมูลสินค้าทั้งหมด
        final selectedProduct = products.firstWhere(
          (product) => product['_id'] == widget.id,
          orElse: () => null,
        );

        if (selectedProduct != null) {
          setState(() {
            product = selectedProduct;
            isLoading = false;  // ปรับให้โหลดเสร็จ
          });
        } else {
          setState(() {
            errorMessage = 'Product not found';
            isLoading = false;
          });
        }
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      print("Error: $e");
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (errorMessage != null) {
      return Scaffold(
        body: Center(child: Text(errorMessage!)),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(product!['name']),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(product!['image'], height: 200),
            ),
            SizedBox(height: 10),
            Text(
              product!['name'],
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.yellow),
                Text(" ${product!['rating']} (${product!['reviews']} Reviews)"),
              ],
            ),
            SizedBox(height: 10),
            Text("Price: ${product!['price']} Bath", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(
              product!['details'],
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
