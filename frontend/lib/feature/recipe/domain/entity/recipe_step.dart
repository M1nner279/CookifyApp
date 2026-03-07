import 'package:equatable/equatable.dart';

class RecipeStep extends Equatable {
  const RecipeStep({required this.imageUrl, required this.description});

  final String? imageUrl;
  final String description;

  @override
  List<Object?> get props => [imageUrl, description];
}
