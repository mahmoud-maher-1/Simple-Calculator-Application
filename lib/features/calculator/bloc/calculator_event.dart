part of 'calculator_bloc.dart';

sealed class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

final class CalculatorDigitPressed extends CalculatorEvent {
  final int digit;

  const CalculatorDigitPressed(this.digit);

  @override
  List<Object> get props => [digit];
}

final class CalculatorOperationPressed extends CalculatorEvent {
  final CalculatorOperation operation;

  const CalculatorOperationPressed(this.operation);

  @override
  List<Object> get props => [operation];
}

final class CalculatorClearPressed extends CalculatorEvent {}

final class CalculatorEqualsPressed extends CalculatorEvent {}
