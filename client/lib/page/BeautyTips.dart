import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:untitled5/page/HomePage.dart'; // Import HomePage

class GlamoraApp extends StatelessWidget {
  const GlamoraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF7D4177),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFF7D4177),
        ),
      ),
      home: const BeautyTipsPage(),
    );
  }
}

class BeautyTipsPage extends StatelessWidget {
  const BeautyTipsPage({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 216, 233),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage1()),
                    );
                  },
                ),
                const Text(
                  'Beauty Tips',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 48), // Placeholder to balance the row
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                BeautyTipCard(
                  title: 'มัดรวม 6 คันแดด ใช้แล้วชอบงานผิวสวย ฉบับคนขี้เกียจแต่งหน้า! ✨',
                  imageUrl: 'https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/og6IINQ2Ae0tvBBlBAgihJITEfuVzGiClAx1NE~tplv-tej9nj120t-origin.webp',
                  onTap: () => _launchUrl('https://www.lemon8-app.com/minniebell/7371750565694423569?region=th'),
                ),
                const SizedBox(height: 10),
                BeautyTipCard(
                  title: 'เซรั่ม 6 สกินแคร์ กู้หน้าสิว คืนผิวใส ด้วยตัวเอง!',
                  imageUrl: 'https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/oQIfiAb7QDJeEgF2AMAAsU3EgELgksuG1JenJs~tplv-tej9nj120t-origin.webp',
                  description: 'รวม 30+ นวัตกรรมรีวิวแน่นมาก หอบมาจากคนที่ใช้เคยแล้วแถมทั้ง วัน 4 เดือนแล้ว...',
                  onTap: () => _launchUrl('https://www.lemon8-app.com/@dahrawadee/7376241086932566529?region=th'),
                ),
                const SizedBox(height: 10),
                BeautyTipCard(
                  title: '⭐ Spring Tone Makeup',
                  imageUrl: 'https://p16-va.lemon8cdn.com/tos-alisg-v-a3e477-sg/0a7f1a2048a6456e915d03168c7831a4~tplv-tej9nj120t-origin.webp',
                  description: 'Blue Makeup เมคอัพโทนฟ้า💙🦋',
                  onTap: () => _launchUrl('https://www.lemon8-app.com/mudmeemakeup/7244373015025205761?region=th'),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 5,
        color: Colors.white,
        margin: const EdgeInsets.only(bottom: 20),
        width: 100,
      ),
    );
  }
}

class BeautyTipCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String? description;
  final VoidCallback onTap;

  const BeautyTipCard({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    if (description != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          description!,
                          style: TextStyle(
                            color: Colors.grey[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}