import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _expressao = '';
  String _resultado = '';

  void _pressionarBotao(String valor) {
    setState(() {
      if (valor == 'C') {
        _expressao = '';
        _resultado = '';
      } else if (valor == '=') {
        _calcularResultado();
      } else if (valor == '⌫') {
        if (_expressao.isNotEmpty) {
          _expressao = _expressao.substring(0, _expressao.length - 1);
        }
      } else {
        _expressao += valor;
      }
    });
  }

  void _calcularResultado() {
    try {
      _resultado = _avaliarExpressao(_expressao).toString();
    } catch (e) {
      _resultado = 'Erro';
    }
  }

  double _avaliarExpressao(String expressao) {
    expressao = expressao.replaceAll('x', '*');
    expressao = expressao.replaceAll('÷', '/');
    ExpressionEvaluator avaliador = const ExpressionEvaluator();
    return avaliador.eval(Expression.parse(expressao), {});
  }

  Widget _botao(String texto, {Color cor = Colors.purple}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Botões arredondados
        ),
      ),
      onPressed: () => _pressionarBotao(texto),
      child: Text(
        texto,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Layout arredondado
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _expressao,
                style: const TextStyle(fontSize: 24, color: Colors.deepPurple),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const Divider(color: Colors.deepPurple),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                _resultado,
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
                textAlign: TextAlign.right,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            flex: 8,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              children: [
                _botao('C', cor: Colors.purple.shade300),
                _botao('⌫', cor: Colors.purple.shade300),
                _botao('(', cor: Colors.purple.shade300),
                _botao(')', cor: Colors.purple.shade300),
                _botao('7', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('8', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('9', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('÷', cor: Colors.amber),
                _botao('4', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('5', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('6', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('x', cor: Colors.amber),
                _botao('1', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('2', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('3', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('-', cor: Colors.amber),
                _botao('0', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('.', cor: const Color.fromARGB(255, 255, 218, 253)),
                _botao('=', cor: Colors.amber.shade700),
                _botao('+', cor: Colors.amber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
