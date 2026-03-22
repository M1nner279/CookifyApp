import 'package:equatable/equatable.dart';

class RecipeStep extends Equatable {
  const RecipeStep({
    this.id,
    required this.imageUrl,
    required this.description,
  });

  final String? id;
  final String? imageUrl;
  final String description;

  @override
  List<Object?> get props => [imageUrl, description];
}
