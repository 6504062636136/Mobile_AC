import 'package:flutter/material.dart';

class BestSellersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Best Sellers'),
        backgroundColor: Colors.pink, // Match the primarySwatch color
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Implement cart functionality
            },
          ),
        ],
      ),
      backgroundColor: Color(0xFF69376D), // พื้นหลังสีม่วง
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFFFDD8E7)),
              child: Text(
                'Menu',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _drawerItem(context, Icons.home, 'Home', '/home'),
            _drawerItem(context, Icons.update, 'Status', '/status'),
            _drawerItem(context, Icons.category, 'Categories', '/categories'),
            _drawerItem(
                context, Icons.local_offer, 'Promotions', '/promotions'),
            _drawerItem(context, Icons.star, 'Best Sellers', '/bestSellers'),
            _drawerItem(context, Icons.favorite, 'Beauty Tips', '/beautyTips'),
            _drawerItem(context, Icons.info, 'About Us', '/about'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              'Best Sellers',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(20),
              children: [
                _buildBestSellerItem(
                  image: 'assets/images/dior.png',
                  brand: 'Dior',
                  description:
                      'Dior Forever Skin Glow 24h Hydrating\nRadiant Foundation - 30ml',
                  rating: 4.8,
                  reviews: 365,
                  price: '2,900.00',
                ),
                _buildBestSellerItem(
                  image: 'assets/images/rare_beauty.png',
                  brand: 'Rare Beauty',
                  description: 'Soft Pinch Liquid Blush - 7.5ml',
                  rating: 4.8,
                  reviews: 17433,
                  price: '1,100.00',
                ),
                _buildBestSellerItem(
                  image: 'assets/images/hourglass.png',
                  brand: 'Hourglass',
                  description: 'Vanish™ Airbrush Concealer',
                  rating: 4.8,
                  reviews: 1182,
                  price: '1,700.00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestSellerItem({
    required String image,
    required String brand,
    required String description,
    required double rating,
    required int reviews,
    required String price,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(image, width: 60, height: 80),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  brand,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  description,
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Text('$rating', style: TextStyle(fontSize: 14)),
                    Icon(Icons.star, color: Colors.yellow, size: 16),
                    Text(' $reviews Reviews', style: TextStyle(fontSize: 12)),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  '$price Bath',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Icon(Icons.favorite_border),
        ],
      ),
    );
  }

  ListTile _drawerItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
