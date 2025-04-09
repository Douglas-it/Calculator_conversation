import 'package:flutter/material.dart';


class ConversorPage extends StatefulWidget {
  const ConversorPage({super.key});

  @override
  _ConversorPageState createState() => _ConversorPageState();
}

class _ConversorPageState extends State<ConversorPage> {
  String baseEntrada = 'Decimal';
  String baseSaida = 'Binário';
  String valorEntrada = '';
  String resultado = '';
  final TextEditingController _controller = TextEditingController();

  final List<String> bases = [
    'Decimal',
    'Binário',
    'Octal',
    'Hexadecimal',
  ];

  bool _validarEntrada(String text) {
    if (text.isEmpty) return true;

    RegExp regExp;

    switch (baseEntrada) {
      case 'Decimal':
        regExp = RegExp(r'^[0-9]+$');
        break;
      case 'Binário':
        regExp = RegExp(r'^[01]+$');
        break;
      case 'Octal':
        regExp = RegExp(r'^[0-7]+$');
        break;
      case 'Hexadecimal':
        regExp = RegExp(r'^[0-9A-Fa-f]+$');
        break;
      default:
        return false;
    }

    return regExp.hasMatch(text);
  }

  void _calcularConversao() {
    if (valorEntrada.isEmpty) {
      setState(() {
        resultado = 'Por favor, insira um valor.';
      });
      return;
    }

    if (!_validarEntrada(valorEntrada)) {
      setState(() {
        resultado = 'Entrada inválida para a base $baseEntrada.';
      });
      return;
    }

    try {
      int valorDecimal;

      switch (baseEntrada) {
        case 'Decimal':
          valorDecimal = int.parse(valorEntrada);
          break;
        case 'Binário':
          valorDecimal = int.parse(valorEntrada, radix: 2);
          break;
        case 'Octal':
          valorDecimal = int.parse(valorEntrada, radix: 8);
          break;
        case 'Hexadecimal':
          valorDecimal = int.parse(valorEntrada, radix: 16);
          break;
        default:
          throw Exception('Base de entrada inválida');
      }

      String valorConvertido;

      switch (baseSaida) {
        case 'Decimal':
          valorConvertido = valorDecimal.toString();
          break;
        case 'Binário':
          valorConvertido = valorDecimal.toRadixString(2);
          break;
        case 'Octal':
          valorConvertido = valorDecimal.toRadixString(8);
          break;
        case 'Hexadecimal':
          valorConvertido = valorDecimal.toRadixString(16).toUpperCase();
          break;
        default:
          throw Exception('Base de saída inválida');
      }

      setState(() {
        resultado = 'Valor convertido: $valorConvertido';
      });
    } catch (e) {
      setState(() {
        resultado = 'Erro: ${e.toString()}';
      });
    }
  }

  void _limparEntrada() {
    setState(() {
      valorEntrada = '';
      resultado = '';
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Bases Numéricas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _limparEntrada,
            tooltip: 'Limpar',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Base de Entrada'),
                      DropdownButton<String>(
                        value: baseEntrada,
                        isExpanded: true,
                        onChanged: (value) {
                          setState(() {
                            baseEntrada = value!;
                            _calcularConversao();
                          });
                        },
                        items: bases.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Base de Saída'),
                      DropdownButton<String>(
                        value: baseSaida,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            baseSaida = newValue!;
                            _calcularConversao();
                          });
                        },
                        items: bases.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Valor de Entrada em $baseEntrada',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.text,
              onChanged: (value) {
                setState(() {
                  valorEntrada = value;
                  _calcularConversao();
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calcularConversao,
              child: const Text('Converter'),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Resultado:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      resultado,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
