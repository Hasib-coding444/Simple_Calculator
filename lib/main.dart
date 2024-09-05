import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatefulWidget {
  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _display = '0';    // Displaying result or input
  String _firstOperand = ''; // Stores first number
  String _secondOperand = ''; // Stores second number
  String _operator = '';    // Stores the operator

  // This function will handle button presses and update the display accordingly.
  void _onPressed(String value) {
    setState(() {
      // Handle clear (C) functionality
      if (value == '⌫') {
        if (_display.length > 1) {
          _display = _display.substring(0, _display.length - 1);
        } else {
          _display = '0';
        }
      }
      // Handle operator input
      else if (value == '+' || value == '-' || value == '*' || value == '/') {
        _firstOperand = _display;
        _operator = value;
        _display = '0';  // Clear display for next number
      }
      // Handle equal button (=)
      else if (value == '=') {
        _secondOperand = _display;
        _calculateResult();
      }
      // Handle number input
      else if (_display == '0') {
        _display = value;
      } else {
        _display += value;
      }
    });
  }

  // Calculate result based on operator and operands
  void _calculateResult() {
    double num1 = double.parse(_firstOperand);
    double num2 = double.parse(_secondOperand);
    double result = 0;

    switch (_operator) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 / num2;
        break;
    }
    _display = result.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
        titleSpacing: 0,
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: EdgeInsets.all(50),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.all(18),
                child: Text(
                  _display,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: _buildButtons(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildButtonRow('6', '7', '8', '9'),
        SizedBox(height: 20),
        _buildButtonRow('2', '3', '4', '5'),
        SizedBox(height: 20),
        _buildButtonRow('1', '0', '.', '/'),
        SizedBox(height: 20),
        _buildButtonRow('+', '-', '*', '⌫'),
        SizedBox(height: 20),
        _buildButtonRow('='),  // Equal button
      ],
    );
  }

  Widget _buildButtonRow(String btn1, [String? btn2, String? btn3, String? btn4]) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildButton(btn1),
          if (btn2 != null) _buildButton(btn2),
          if (btn3 != null) _buildButton(btn3),
          if (btn4 != null) _buildButton(btn4),
        ],
      ),
    );
  }

  Widget _buildButton(String value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Expanded(
        child: ElevatedButton(
          onPressed: () => _onPressed(value),
          child: Text(
            value,
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}
