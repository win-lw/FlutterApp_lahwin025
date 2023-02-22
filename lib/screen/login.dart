import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:workshop/screen/Home.dart';
import 'package:workshop/screen/reg.dart';

import 'api_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlUsername = TextEditingController();
  final _ctrlPassword = TextEditingController();

  ApiProvider apiProvider = ApiProvider();

  Future doLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        var rs =
            await apiProvider.doLogin(_ctrlUsername.text, _ctrlPassword.text);
        if (rs.statusCode == 200) {
          print(rs.body);
          var jsonRes = json.decode(rs.body);

          if (jsonRes['ok']) {
            String token = jsonRes['token'];
            print(token);

            //SharedPreferences prefs = await SharedPreferences.getInstance();
            //await prefs.setString('token', token);

            //redirect
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Homescreen()));
          } else {
            print(jsonRes['error']);

          }
        } else {
          print('server error!');
        }
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
    title: const Text('Login'),
    backgroundColor: Colors.blue,
  ),

  body: SingleChildScrollView(
    child: Container(
      margin: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _ctrlUsername,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Username',
              labelStyle: TextStyle(color: Colors.blue),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
                    
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _ctrlPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.blue),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
                  ),
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    doLogin();
                  },
                  child: Text('Log in', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Background color of the button
              onPrimary: Colors.white, // Text color of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Rounded shape
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
                ),
                SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegistrationForm()),
                    );
                  },
                  child: Text('Create account', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
              primary: Colors.blue, // Background color of the button
              onPrimary: Colors.white, // Text color of the button
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Rounded shape
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
            ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  ),
);




  }
}
