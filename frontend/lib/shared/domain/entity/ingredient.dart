import 'package:cookify/shared/domain/entity/cpfc.dart';
import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  const Ingredient({this.id, required this.name, required this.cpfc});

  final String? id;
  final String name;
  final Cpfc cpfc;

  @override
  List<Object?> get props => [id, name, cpfc];
}
