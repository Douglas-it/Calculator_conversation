// lib/splash_screen.dart

import 'package:flutter/material.dart';
import 'calculator.dart'; // ou onde estiver o app principal

class SplashScreen extends StatefulWidget { // Tela de Splash
  const SplashScreen({super.key}); // Construtor

  @override
  State<SplashScreen> createState() => _SplashScreenState(); // Estado
}

class _SplashScreenState extends State<SplashScreen> { // Estado da Tela de Splash
  @override
  void initState() { // Inicialização
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement( // Navegação para a tela principal
        context,
        MaterialPageRoute(builder: (context) => const Calculator()), // ou onde estiver o app principal
      );
    });
  }

  @override
  Widget build(BuildContext context) { // Construção da Tela de Splash
    return Scaffold( // Estrutura da Tela
      backgroundColor: Colors.deepPurple, // Cor de fundo
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinhamento central
          children: [
            Image.asset('assets/splash.png', width: 200), // Imagem do logo
            const SizedBox(height: 24), // Espaçamento
            const Text(
              'Gates Math',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
