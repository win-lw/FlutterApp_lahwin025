import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:workshop/screen/login.dart';


class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

  body: Container(

    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Homepage",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.blue,

            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Logout logic
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> LoginScreen()));
            },
            child: Text(
              "Logout",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    ),
  ),
);

  }
}
