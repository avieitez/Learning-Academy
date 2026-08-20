enum MathOperation { addition, subtraction, multiplication, division }

extension MathOperationSymbol on MathOperation {
  String get symbol => switch (this) {
    MathOperation.addition => '+',
    MathOperation.subtraction => '−',
    MathOperation.multiplication => '×',
    MathOperation.division => '÷',
  };
}
