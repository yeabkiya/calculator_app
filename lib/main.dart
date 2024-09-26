import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';    // Input string shown on display
  String _result = '';   // Final result after calculation
  String? _operator;     // Holds the selected operator
  double? _firstOperand; // First operand for calculations

  // This function is called when number buttons are pressed
  void _numberPressed(String number) {
    setState(() {
      _input += number;
    });
  }

  // This function is called when operator buttons (+, -, *, /) are pressed
  void _operatorPressed(String operator) {
    setState(() {
      if (_input.isNotEmpty) {
        _firstOperand = double.parse(_input);
        _input = '';  // Clear the input to enter the second operand
        _operator = operator; // Store the selected operator
      }
    });
  }

  // This function is called when the "=" button is pressed
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
                : 'Error';  // Handle division by zero
            break;
          default:
            _result = 'Error';
        }
        _input = _result; // Update input with result
        _firstOperand = null; // Reset operands and operator
        _operator = null;
      }
    });
  }

  // This function is called when the "C" (clear) button is pressed
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
        title: Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Display Area for input and result
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _input.isEmpty ? '0' : _input,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _result,
              style: TextStyle(fontSize: 32, color: Colors.grey),
            ),
          ),
          // Number and operator buttons
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
      ),
    );
  }

  // Helper function to build a row of buttons
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

  // Helper function to build each button
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
              _operatorPressed(label);  // This now works
            } else {
              _numberPressed(label);
            }
          },
          child: Text(
            label,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
