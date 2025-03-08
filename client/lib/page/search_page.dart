import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];
  bool _isLoading = false;
  String? _errorMessage;

  // ฟังก์ชันการค้นหาข้อมูลจาก API
  Future<void> searchProducts(String query) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // ทำการเรียก API ตามคำค้นหา
      final response = await http.get(Uri.parse('http://localhost:5002/api/search?query=$query'));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _searchResults = data;  // เก็บข้อมูลผลการค้นหา
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField สำหรับการกรอกคำค้นหา
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search for products...",
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      searchProducts(_searchController.text);
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20),

            // แสดงผลลัพธ์การค้นหา
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : _errorMessage != null
                    ? Center(child: Text(_errorMessage!))
                    : Expanded(
                        child: ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            final item = _searchResults[index];
                            return ListTile(
                              leading: Image.network(item['image'], width: 50),
                              title: Text(item['name']),
                              subtitle: Text(item['details']),
                              trailing: Text('${item['price']} Bath'),
                              onTap: () {
                                // อาจจะไปหน้าแสดงรายละเอียดสินค้า
                              },
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
