import 'package:calculator/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS','=',
  ];

  String input = '';

  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: 40),
                    Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerLeft,
                        child: Text(input, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                    Container(
                        padding: const EdgeInsets.all(20),
                        alignment: Alignment.centerRight,
                        child: Text(output, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))),
                  ],
                ),
              )),

          Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.all(5),
                child: GridView.builder(
                    itemCount: buttons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      // Clear button
                      if(index == 0) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              input = '';
                              output = '';
                            });
                          },
                          buttonText: buttons[index],
                          color:  Colors.green,
                          textColor: Colors.white,
                        );
                        // Delete button
                      } else if (index == 1) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              input = input.substring(0, input.length - 1);
                            });
                          },
                          buttonText: buttons[index],
                          color: Colors.red,
                          textColor: Colors.white,
                        );
                        // Equal button
                      } else if (index == buttons.length - 1) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              calculate();
                              input = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.deepPurple :  Colors.deepPurple[50],
                          textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                        );
                        // Ans button
                      } else if (index == buttons.length - 2) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              input = output;
                              output = '';
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.deepPurple :  Colors.deepPurple[50],
                          textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                        );
                        // Operator buttons
                      } else if (isOperator(buttons[index])) {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              if (input.endsWith('+') || input.endsWith('-') || input.endsWith('x') || input.endsWith('/')) {
                                return null;
                              } else {
                                input += buttons[index];
                              }
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.deepPurple :  Colors.deepPurple[50],
                          textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                        );
                        // Rest of the buttons
                      }
                      else  {
                        return MyButton(
                          buttonTapped: () {
                            setState(() {
                              if (output.isNotEmpty) {
                                output = '';
                              }
                              input += buttons[index];
                            });
                          },
                          buttonText: buttons[index],
                          color: isOperator(buttons[index]) ? Colors.deepPurple :  Colors.deepPurple[50],
                          textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                        );
                      }
                    },),
              )),
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if (x == '%' || x == '/' || x == 'x' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }

  void calculate() {
    String finalInput = input;
    finalInput = finalInput.replaceAll('x', '*');

    try {
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      output = eval.toString();
      finalInput = '';
    } catch (e) {
      print('Error');
    }
  }
}




