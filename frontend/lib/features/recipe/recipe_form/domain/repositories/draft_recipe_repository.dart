import 'package:cookify/features/recipe/recipe_form/domain/entities/draft_recipe_entity.dart';
import 'package:flutter/foundation.dart';

abstract interface class DraftRecipeRepository {
  ValueListenable<List<DraftRecipeEntity>> get draftsListenable;

  List<DraftRecipeEntity> get drafts;

  DraftRecipeEntity? getById(String id);

  Future<void> init();

  Future<DraftRecipeEntity> upsert(DraftRecipeEntity draft);

  Future<void> remove(String id);
}

