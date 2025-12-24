part of 'calculator_bloc.dart';

enum CalculatorOperation { addition, subtraction, multiplication, division, none }

enum CalculatorStatus { initial, success, failure }

final class CalculatorState extends Equatable {
  const CalculatorState({
    this.displayValue = '0',
    this.bufferValue = 0,
    this.operation = CalculatorOperation.none,
    this.status = CalculatorStatus.initial,
    this.shouldResetDisplay = false,
  });

  final String displayValue;
  final double bufferValue;
  final CalculatorOperation operation;
  final CalculatorStatus status;
  final bool shouldResetDisplay;

  CalculatorState copyWith({
    String? displayValue,
    double? bufferValue,
    CalculatorOperation? operation,
    CalculatorStatus? status,
    bool? shouldResetDisplay,
  }) {
    return CalculatorState(
      displayValue: displayValue ?? this.displayValue,
      bufferValue: bufferValue ?? this.bufferValue,
      operation: operation ?? this.operation,
      status: status ?? this.status,
      shouldResetDisplay: shouldResetDisplay ?? this.shouldResetDisplay,
    );
  }

  @override
  List<Object> get props => [displayValue, bufferValue, operation, status, shouldResetDisplay];
}
