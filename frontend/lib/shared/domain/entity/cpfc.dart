import 'package:equatable/equatable.dart';

class Cpfc extends Equatable {
  const Cpfc({
    required this.calories,
    required this.proteins,
    required this.fats,
    required this.carbohydrates,
  });

  final int calories;
  final int proteins;
  final int fats;
  final int carbohydrates;

  @override
  List<Object?> get props => [calories, proteins, fats, carbohydrates];
}
