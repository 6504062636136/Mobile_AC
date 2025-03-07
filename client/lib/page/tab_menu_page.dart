import 'dart:convert';
import 'package:flutter/material.dart';

class TabMenuPage extends StatefulWidget {
  const TabMenuPage({super.key, required this.username, required this.avatarUrl});
  final String username;
  final String avatarUrl;


  @override
  State<StatefulWidget> createState() {
    return _TabmenuPageState();
  }
  void _logout(BuildContext context) {
    Navigator.pop(context);
  }
}

class _TabmenuPageState extends State<TabMenuPage> {
  late String _username;
  late String _avatarUrl;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _avatarUrl = widget.avatarUrl;
  }

  @override
  Widget build(BuildContext context) {
      return DefaultTabController(
        length: 3, 
        child: Scaffold(
          appBar: AppBar(title: const Text('Myapp'),
          bottom: const TabBar(tabs: [
            Tab(text: 'Home'),
            Tab(text: 'Contact',icon: Icon(Icons.contact_mail),),
            Tab(text: 'Profile')
          ]),
        ),
        body: TabBarView(children: [
          const Center(child: Text('Home')
          ),
          const Center(child: Text('Contact')
          ),
          Padding(padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(_avatarUrl),
              ),
              const SizedBox(height: 10),
              Text(_username, style: const TextStyle(fontSize: 20)
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => widget._logout(context),
                child: const Text('Logout'),
              )
            ],
          ))
        ]),
      ));
    }
  }