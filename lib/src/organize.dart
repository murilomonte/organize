import 'package:flutter/material.dart';
import 'package:organize/src/view/navigation.dart';

class Organize extends StatelessWidget {
  final bool isFirstLogin = false;

  const Organize({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: isFirstLogin ? Placeholder() : Navigation(),
    );
  }
}