import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String? message;
  const ErrorView({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Error')),
      body: Center(
        child: Column(
          children: [
            Text('An error occoured'),
            if (message != null) Text(message!),
          ],
        ),
      ),
    );
  }
}
