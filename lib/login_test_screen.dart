
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class LoginTestScreen extends StatefulWidget {
  @override
  _LoginTestScreenState createState() => _LoginTestScreenState();
}
class _LoginTestScreenState extends State<LoginTestScreen> {
  final String apiEndpoint = 'http://185.132.55.54:8000/login/';
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> sendPostRequest() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> data = {
        'email': _emailController.text,
        'password': _passwordController.text,
      };
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
      var response = await http.post(Uri.parse(apiEndpoint),
          headers: headers, body: jsonEncode(data));
      if (response.statusCode == 200) {
        // Success
        var responseBody = jsonDecode(response.body);
        print(responseBody);
      } else {
        // Error
        print('Error: ${response.reasonPhrase}');
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Sign Up',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
               
                SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: sendPostRequest,
                  child: Text('Sign Up'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class LoginTestScreen extends StatefulWidget {
  @override
  _LoginTestScreen createState() => _LoginTestScreen();
}
class _LoginTestScreen extends State<LoginTestScreen> {
 final String apiEndpoint = 'http://185.132.55.54:8000/logout/';//'http://185.132.55.54:8000/logout/';
  Map<String, dynamic> data = {
    'email': 'mugonoj.raneno@rungel.net', 
    'password': '253200113',
  };
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    //'Content-Length': '76',
    //'Authorization': '7.32.2',
  };
  Future<void> sendPostRequest() async {
    var response = await http.post(Uri.parse(apiEndpoint),
        headers: headers, body: jsonEncode(data));
    if (response.statusCode == 200) {
      // Success
      var responseBody = jsonDecode(response.body);
      print(responseBody);
    } else {
      // Error
      print('Error: ${response.reasonPhrase}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticated Post Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Press the button to send a post request',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendPostRequest,
              child: Text('Send Post Request'),
            ),
          ],
        ),
      ),
    );
  }
}



*/