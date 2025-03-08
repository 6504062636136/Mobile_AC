import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SkincareDetailScreen extends StatefulWidget {
  final String id;

  const SkincareDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  _SkincareDetailScreenState createState() => _SkincareDetailScreenState();
}

class _SkincareDetailScreenState extends State<SkincareDetailScreen> {
  Map<String, dynamic>? _productDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchProductDetail();
  }

  Future<void> _fetchProductDetail() async {
    final String apiUrl = "http://localhost:5001/api/skincare/${widget.id}";

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);

        setState(() {
          _productDetail = jsonData;
          _isLoading = false;
        });
      } else {
        print('Failed to load product detail. Status Code: ${response.statusCode}');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _productDetail != null ? _productDetail!['name'] ?? 'Product Detail' : 'Product Detail',
            style: const TextStyle(
              fontFamily: 'Arial',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.lightBlue[100],
          foregroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
          ),
        )
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Product Image
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _productDetail!['image'] != null
                            ? Image.network(
                          _productDetail!['image'],
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.error),
                          height: 250,
                        )
                            : const SizedBox.shrink(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Product Name
                    Text(
                      _productDetail!['name'] ?? 'No Name',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Arial',
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Show Type only
                    Text(
                      'Type: ${_productDetail!['type'] ?? 'N/A'}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: 'Arial',
                      ),
                    ),
                  ],
                ),
              ),

              // Price at the Bottom Right
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  'B${_productDetail!['price']?.toString() ?? '0.00'}', // แสดงราคาเป็น B
                  style: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Roboto',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
