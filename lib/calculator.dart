import 'package:flutter/material.dart';
import 'pages/conversor_page.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key}); // App principal

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      title: 'Conversor de Bases',
      theme: ThemeData (
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ConversorPage(),
    );
  }
}
