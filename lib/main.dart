import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalculatorApp(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _result = '';
  String? _operator;
  double? _firstOperand;

  void _numberPressed(String number) {
    setState(() {
      _input += number;
    });
  }

  void _operatorPressed(String operator) {
    setState(() {
      if (_input.isNotEmpty) {
        _firstOperand = double.parse(_input);
        _input = '';
        _operator = operator;
      }
    });
  }

  void _calculateResult() {
    setState(() {
      if (_input.isNotEmpty && _firstOperand != null && _operator != null) {
        double secondOperand = double.parse(_input);
        switch (_operator) {
          case '+':
            _result = (_firstOperand! + secondOperand).toString();
            break;
          case '-':
            _result = (_firstOperand! - secondOperand).toString();
            break;
          case '*':
            _result = (_firstOperand! * secondOperand).toString();
            break;
          case '/':
            _result = secondOperand != 0
              ? (_firstOperand! / secondOperand).toString()
              : 'Error';
            break;
          default:
            _result = 'Error';
        }
        _input = _result; 
        _firstOperand = null;
        _operator = null;
      }
    });
  }

  void _clearInput() {
    setState(() {
      _input = '';
      _result = '';
      _operator = null;
      _firstOperand = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _input.isEmpty ? '0' : _input,
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: const TextStyle(fontSize:32, color: Colors.grey),
            ),
          ),

          Expanded(
            child: Column(
              children: [
                _buildButtonRow('7', '8', '9', '/'),
                _buildButtonRow('4', '5', '6', '*'),
                _buildButtonRow('1', '2', '3', '-'),
                _buildButtonRow('0', 'C', '=', '+'),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildButtonRow(String first, String second, String third, String fourth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _buildButton(first),
        _buildButton(second),
        _buildButton(third),
        _buildButton(fourth),
      ],
    );
  }

  Widget _buildButton(String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (label == 'C') {
              _clearInput();
            } else if (label == '=') {
              _calculateResult();
            } else if ('+-*/'.contains(label)) {
              _operatorPressed(label);
            } else {
              _numberPressed(label);
            }
          },
          child: Text(
            label,
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
