import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled5/page/tab_menu_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _navigatorKey = GlobalKey<NavigatorState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _login() async {
    final url = Uri.parse(' https://www.melivecode.com/api/login');
    final header = {'Content-Type': 'application/json'};
    final body = jsonEncode(
      {
        'username': _usernameController.text,
        'password': _passwordController.text,
      },
    );

    final response = await http.post(url, headers: header, body: body);
    if (response.statusCode != 200) {
      final jsonReponse = jsonDecode(response.body);
      _showSnackBar(jsonReponse['message']);
      var jsonResponse = jsonDecode(response.body);
      _navigatorKey.currentState!.push(MaterialPageRoute(
          builder: (context) => TabMenuPage(
              username: jsonResponse['user']['username'],
              avatarUrl: jsonResponse['user']['avatarUrl'])));
    } else if (response.statusCode == 401) {
      final jsonResponse = jsonDecode(response.body);
      _showSnackBar(jsonResponse['message']);
    }
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _navigatorKey,
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: Text('Login'),
              ),
              body: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login();
                          // Perform login action
                          print('Username: ${_usernameController.text}');
                          print('Password: ${_passwordController.text}');
                        }
                      },
                      child: Text('Login'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
