import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'calculator_event.dart';
part 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    on<CalculatorDigitPressed>(_onDigitPressed);
    on<CalculatorOperationPressed>(_onOperationPressed);
    on<CalculatorEqualsPressed>(_onEqualsPressed);
    on<CalculatorClearPressed>(_onClearPressed);
  }

  void _onDigitPressed(
    CalculatorDigitPressed event,
    Emitter<CalculatorState> emit,
  ) {
    if (state.shouldResetDisplay) {
      emit(state.copyWith(
        displayValue: event.digit.toString(),
        shouldResetDisplay: false,
      ));
    } else {
      final currentDisplay = state.displayValue;
      final newDisplay =
          currentDisplay == '0' ? event.digit.toString() : '$currentDisplay${event.digit}';
      emit(state.copyWith(displayValue: newDisplay));
    }
  }

  void _onOperationPressed(
    CalculatorOperationPressed event,
    Emitter<CalculatorState> emit,
  ) {
    // If an operation was already pressed and we haven't entered a new number yet,
    // just update the operation.
    if (state.shouldResetDisplay && state.operation != CalculatorOperation.none) {
      emit(state.copyWith(operation: event.operation));
      return;
    }

    final inputValue = double.tryParse(state.displayValue) ?? 0;

    // If there is a pending operation, calculate the intermediate result
    if (state.operation != CalculatorOperation.none) {
      final result = _calculate(state.bufferValue, inputValue, state.operation);
      emit(state.copyWith(
        displayValue: _formatResult(result),
        bufferValue: result,
        operation: event.operation,
        shouldResetDisplay: true,
      ));
    } else {
      // First operand
      emit(state.copyWith(
        bufferValue: inputValue,
        operation: event.operation,
        shouldResetDisplay: true,
      ));
    }
  }

  void _onEqualsPressed(
    CalculatorEqualsPressed event,
    Emitter<CalculatorState> emit,
  ) {
    if (state.operation == CalculatorOperation.none) return;

    final inputValue = double.tryParse(state.displayValue) ?? 0;
    final result = _calculate(state.bufferValue, inputValue, state.operation);

    emit(state.copyWith(
      displayValue: _formatResult(result),
      bufferValue: 0,
      operation: CalculatorOperation.none,
      shouldResetDisplay: true,
    ));
  }

  void _onClearPressed(
    CalculatorClearPressed event,
    Emitter<CalculatorState> emit,
  ) {
    emit(const CalculatorState());
  }

  double _calculate(double left, double right, CalculatorOperation operation) {
    switch (operation) {
      case CalculatorOperation.addition:
        return left + right;
      case CalculatorOperation.subtraction:
        return left - right;
      case CalculatorOperation.multiplication:
        return left * right;
      case CalculatorOperation.division:
        if (right == 0) return 0; // Handle division by zero
        return left / right;
      case CalculatorOperation.none:
        return right;
    }
  }

  String _formatResult(double value) {
    // Remove trailing .0 for integers
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }
}
