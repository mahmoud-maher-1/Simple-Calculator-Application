import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:calculator_app/features/calculator/bloc/calculator_bloc.dart';

class CalculatorView extends StatelessWidget {
  const CalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(24),
                child: BlocBuilder<CalculatorBloc, CalculatorState>(
                  builder: (context, state) {
                    return Text(
                      state.displayValue,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.right,
                    );
                  },
                ),
              ),
            ),
            _buildButtonRow(context, ['7', '8', '9', '/']),
            _buildButtonRow(context, ['4', '5', '6', '*']),
            _buildButtonRow(context, ['1', '2', '3', '-']),
            _buildButtonRow(context, ['C', '0', '=', '+']),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonRow(BuildContext context, List<String> items) {
    return Row(
      children: items.map((item) {
        return Expanded(
          child: _CalculatorButton(text: item),
        );
      }).toList(),
    );
  }
}

class _CalculatorButton extends StatelessWidget {
  final String text;

  const _CalculatorButton({required this.text});

  @override
  Widget build(BuildContext context) {
    final isOperator = ['/', '*', '-', '+', '='].contains(text);
    final isClear = text == 'C';
    final color = isOperator
        ? Colors.orange
        : isClear
            ? Colors.grey
            : Colors.grey[850];
    final textColor = isClear ? Colors.black : Colors.white;

    return Container(
      margin: const EdgeInsets.all(8),
      child: AspectRatio(
        aspectRatio: 1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            foregroundColor: textColor,
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () {
            final bloc = context.read<CalculatorBloc>();
            if (int.tryParse(text) != null) {
              bloc.add(CalculatorDigitPressed(int.parse(text)));
            } else if (isOperator && text != '=') {
              CalculatorOperation operation;
              switch (text) {
                case '/':
                  operation = CalculatorOperation.division;
                  break;
                case '*':
                  operation = CalculatorOperation.multiplication;
                  break;
                case '-':
                  operation = CalculatorOperation.subtraction;
                  break;
                case '+':
                  operation = CalculatorOperation.addition;
                  break;
                default:
                  operation = CalculatorOperation.none;
              }
              bloc.add(CalculatorOperationPressed(operation));
            } else if (text == '=') {
              bloc.add(CalculatorEqualsPressed());
            } else if (text == 'C') {
              bloc.add(CalculatorClearPressed());
            }
          },
          child: Text(
            text == '*'
                ? 'x'
                : text == '/'
                    ? '÷'
                    : text,
            style: const TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
