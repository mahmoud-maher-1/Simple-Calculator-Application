import 'package:calculator_app/features/calculator/bloc/calculator_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('CalculatorBloc', () {
    late CalculatorBloc calculatorBloc;

    setUp(() {
      calculatorBloc = CalculatorBloc();
    });

    test('initial state is correct', () {
      expect(calculatorBloc.state, const CalculatorState());
    });

    blocTest<CalculatorBloc, CalculatorState>(
      'emits [displayValue: 1] when digit 1 is pressed',
      build: () => calculatorBloc,
      act: (bloc) => bloc.add(const CalculatorDigitPressed(1)),
      expect: () => [
        const CalculatorState(displayValue: '1'),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'performs addition correctly: 2 + 2 = 4',
      build: () => calculatorBloc,
      act: (bloc) {
        bloc.add(const CalculatorDigitPressed(2));
        bloc.add(const CalculatorOperationPressed(CalculatorOperation.addition));
        bloc.add(const CalculatorDigitPressed(2));
        bloc.add(CalculatorEqualsPressed());
      },
      expect: () => [
        const CalculatorState(displayValue: '2'),
        const CalculatorState(
            displayValue: '2',
            bufferValue: 2,
            operation: CalculatorOperation.addition,
            shouldResetDisplay: true),
        const CalculatorState(
            displayValue: '2',
            bufferValue: 2,
            operation: CalculatorOperation.addition,
            shouldResetDisplay: false),
        const CalculatorState(
            displayValue: '4',
            bufferValue: 0,
            operation: CalculatorOperation.none,
            shouldResetDisplay: true),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'performs subtraction correctly: 5 - 3 = 2',
      build: () => calculatorBloc,
      act: (bloc) {
        bloc.add(const CalculatorDigitPressed(5));
        bloc.add(const CalculatorOperationPressed(CalculatorOperation.subtraction));
        bloc.add(const CalculatorDigitPressed(3));
        bloc.add(CalculatorEqualsPressed());
      },
      expect: () => [
        const CalculatorState(displayValue: '5'),
        const CalculatorState(
            displayValue: '5',
            bufferValue: 5,
            operation: CalculatorOperation.subtraction,
            shouldResetDisplay: true),
        const CalculatorState(
            displayValue: '3',
            bufferValue: 5,
            operation: CalculatorOperation.subtraction,
            shouldResetDisplay: false),
        const CalculatorState(
            displayValue: '2',
            bufferValue: 0,
            operation: CalculatorOperation.none,
            shouldResetDisplay: true),
      ],
    );
    
     blocTest<CalculatorBloc, CalculatorState>(
      'performs division correctly: 10 / 2 = 5',
      build: () => calculatorBloc,
      act: (bloc) {
        bloc.add(const CalculatorDigitPressed(1));
        bloc.add(const CalculatorDigitPressed(0));
        bloc.add(const CalculatorOperationPressed(CalculatorOperation.division));
        bloc.add(const CalculatorDigitPressed(2));
        bloc.add(CalculatorEqualsPressed());
      },
      expect: () => [
        const CalculatorState(displayValue: '1'),
         const CalculatorState(displayValue: '10'),
        const CalculatorState(
            displayValue: '10',
            bufferValue: 10,
            operation: CalculatorOperation.division,
            shouldResetDisplay: true),
        const CalculatorState(
            displayValue: '2',
            bufferValue: 10,
            operation: CalculatorOperation.division,
            shouldResetDisplay: false),
        const CalculatorState(
            displayValue: '5',
            bufferValue: 0,
            operation: CalculatorOperation.none,
            shouldResetDisplay: true),
      ],
    );
     
      blocTest<CalculatorBloc, CalculatorState>(
      'performs multiplication correctly: 4 * 3 = 12',
      build: () => calculatorBloc,
      act: (bloc) {
        bloc.add(const CalculatorDigitPressed(4));
        bloc.add(const CalculatorOperationPressed(CalculatorOperation.multiplication));
        bloc.add(const CalculatorDigitPressed(3));
        bloc.add(CalculatorEqualsPressed());
      },
      expect: () => [
        const CalculatorState(displayValue: '4'),
        const CalculatorState(
            displayValue: '4',
            bufferValue: 4,
            operation: CalculatorOperation.multiplication,
            shouldResetDisplay: true),
        const CalculatorState(
            displayValue: '3',
            bufferValue: 4,
            operation: CalculatorOperation.multiplication,
            shouldResetDisplay: false),
        const CalculatorState(
            displayValue: '12',
            bufferValue: 0,
            operation: CalculatorOperation.none,
            shouldResetDisplay: true),
      ],
    );

    blocTest<CalculatorBloc, CalculatorState>(
      'clears state when C is pressed',
      build: () => calculatorBloc,
      act: (bloc) {
        bloc.add(const CalculatorDigitPressed(5));
        bloc.add(CalculatorClearPressed());
      },
      expect: () => [
        const CalculatorState(displayValue: '5'),
        const CalculatorState(),
      ],
    );
  });
}
