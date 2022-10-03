import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          image: DecorationImage(
            image: AssetImage('assets/1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
