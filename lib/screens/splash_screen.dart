import 'dart:async';

import 'package:flutter/material.dart';

class SpalshScreen extends StatelessWidget {
  static const routeName = '/spalsh';
  const SpalshScreen({super.key});
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 4), () {
      Navigator.of(context).pop();
    });
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 20,
            ),
            Icon(
              Icons.ac_unit,
              color: Colors.amber,
              size: 140,
            ),
          ],
        ),
      ),
    );
  }
}
