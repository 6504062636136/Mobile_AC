import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'attractions_detail_screen.dart';

class AttractionScreen extends StatefulWidget {
  const AttractionScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AttractionScreen();
  }
}

class _AttractionScreen extends State<AttractionScreen> {
  List<dynamic> _attraction = [];
  @override
  void initState(){
    super.initState();
    _fetchAttractions();
  }
  Future<void> _fetchAttractions() async{
    // Fetch data from API
    // Set data to _attractionList
    final response = await http.get(Uri.parse('https://www.melivecode.com/api/attractions'));
    setState(() {
          _attraction = json.decode(response.body);
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attraction'),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Color.fromARGB(255, 216, 210, 210),
      ),
      body: ListView.builder(itemCount: _attraction.length,itemBuilder: (context, index){
        final attraction = _attraction[index];
        return ListTile(
          leading: SizedBox(width: MediaQuery.of(context).size.width*0.2,child: Image.network(attraction['coverimage'])),
          title: Row(
            children: [
              Text(attraction['name']),
             // Text(attraction['location']),
            ],
          ),
          subtitle:Text(attraction['detail'],
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          ), 
          onTap: () {
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AttractionDetailScreen(id: attraction['id'])));
          }
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'cart_provider.dart'; // Import CartProvider
// import 'cart_item.dart'; // Import CartItem
// import 'cart_page.dart'; // Import CartPage
//
// class ProductDetailPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF2CACA), // สีพื้นหลัง
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context); // กลับไปหน้าก่อนหน้า
//           },
//         ),
//         title: Center(
//           child: Text(
//             'M.A.C',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: Colors.black,
//             ),
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.share, color: Colors.black),
//             onPressed: () {
//               // TODO: Implement Share Functionality
//             },
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // รูปสินค้า
//             Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 color: Colors.white,
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Image.asset(
//                   'assets/images/mac_lipstick.png', // แทนที่ด้วย path ที่ถูกต้อง
//                   width: double.infinity,
//                   height: 300,
//                   fit: BoxFit.contain, // หรือ BoxFit.cover ตามความเหมาะสม
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//
//             // ชื่อสินค้า
//             Text(
//               'M.A.C Macximal Silky Matte Lipstick',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             SizedBox(height: 10),
//
//             // คะแนนและรีวิว
//             Row(
//               children: <Widget>[
//                 Icon(Icons.star, color: Colors.amber),
//                 Text('5.0'),
//                 Text(' (10 Reviews)'),
//               ],
//             ),
//             SizedBox(height: 20),
//
//             // สี
//             Text(
//               'Color',
//               style: TextStyle(fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: <Widget>[
//                 ColorOption(color: Color(0xFFFFD8E7)), // สีชมพูอ่อน
//                 ColorOption(color: Color(0xFFF8BBD0)), // สีชมพู
//                 ColorOption(color: Color(0xFFEF9A9A)), // สีแดงชมพู
//                 ColorOption(color: Color(0xFFE57373)), // สีแดง
//               ],
//             ),
//             SizedBox(height: 30),
//
//             // ปุ่ม Add to Cart และ Order Now
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.white,
//                     foregroundColor: Colors.deepPurple[400],
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     textStyle: TextStyle(fontSize: 18),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: () {
//                     // สร้าง CartItem จากข้อมูลสินค้า
//                     final cartItem = CartItem(
//                       id: '123', // ควรเป็น ID ที่ไม่ซ้ำกัน
//                       title: 'M.A.C Macximal Silky Matte Lipstick',
//                       price: 25.0, // ราคาจริงของสินค้า
//                       imageUrl: 'assets/images/mac_lipstick.png', // URL รูปภาพ
//                     );
//
//                     // เพิ่มสินค้าลงใน Cart โดยใช้ CartProvider
//                     final cartProvider = Provider.of<CartProvider>(context, listen: false);
//                     cartProvider.addItem(cartItem);
//
//                     // นำทางไปยังหน้า Cart
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => CartPage()),
//                     );
//                   },
//                   child: Text('Add to Cart'),
//                 ),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.deepPurple[400],
//                     padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
//                     textStyle: TextStyle(fontSize: 18),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30),
//                     ),
//                   ),
//                   onPressed: () {
//                     // TODO: Implement Order Now Functionality
//                   },
//                   child: Text('Order Now', style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Widget สำหรับแต่ละตัวเลือกสี
// class ColorOption extends StatelessWidget {
//   final Color color;
//
//   const ColorOption({
//     Key? key,
//     required this.color,this
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 30,
//       height: 30,
//       margin: EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: color,
//         border: Border.all(
//           color: Colors.black26,
//           width: 1,
//         ),
//       ),
//     );
//   }
// }

