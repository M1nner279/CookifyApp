import 'package:cookify/feature/recipe/config/enum/product_unit.dart';
import 'package:cookify/feature/recipe/domain/entity/cpfc.dart';
import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  const Ingredient({
    required this.id,
    required this.name,
    required this.cpfc,
    required this.unit,
  });

  final String id;
  final String name;
  final Cpfc cpfc;
  final ProductUnit unit;

  @override
  List<Object?> get props => [id, name, cpfc, unit];
}
