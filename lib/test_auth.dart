import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthenticatedPost extends StatefulWidget {
  @override
  _AuthenticatedPostState createState() => _AuthenticatedPostState();
}

class _AuthenticatedPostState extends State<AuthenticatedPost> {
  final String apiEndpoint = 'http://185.132.55.54:8000/Registrnewuser/';
  Map<String, dynamic> data = {
    'email': 'mohammedsabry@cashone-eg.com',
    'password': '108530',
    'first_name':'MOHAMED',
    'last_name':'AHMED',
  };
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    
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


/*

@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authenticated Post Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: sendPostRequest,
          child: Text('Send Post Request'),
        ),
      ),
    );
  }
*/