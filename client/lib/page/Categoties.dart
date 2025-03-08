import 'package:flutter/material.dart';
import 'attraction_screen.dart'; // นำเข้า AttractionScreen
import 'skincare_screen.dart'; // นำเข้า SkincareScreen

class CategoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {
      "name": "Makeup",
      "icon": Icons.brush,
      "route": () => ProductScreen(id: 1), // ใช้ฟังก์ชันเพื่อสร้าง instance
    },
    {
      "name": "Skin Care",
      "icon": Icons.spa,
      "route": () => SkincareScreen(), // ใช้ฟังก์ชันเพื่อสร้าง instance
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 185, 235, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 204, 238),
        elevation: 0,
        title: Text("GLAMORA", style: TextStyle(color: const Color.fromARGB(255, 83, 26, 105))),
       
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            _buildCategoryList(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList(BuildContext context) {
    return Column(
      children: categories.map((category) {
        return _buildCategoryCard(
          context,
          category["name"],
          category["icon"],
          category["route"], // ใช้ฟังก์ชันแทน Widget ตรงๆ
        );
      }).toList(),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String title, IconData iconData, Widget Function() routeBuilder) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => routeBuilder(), // เรียกใช้ฟังก์ชันเพื่อสร้าง instance
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: EdgeInsets.only(bottom: 16),
        child: Container(
          width: double.infinity,
          height: 150,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Icon(iconData, size: 40, color: Colors.deepPurple),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
