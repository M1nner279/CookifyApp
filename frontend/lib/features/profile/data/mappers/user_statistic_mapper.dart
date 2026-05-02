import 'package:cookify/features/profile/data/models/user_statistic_model.dart';
import 'package:cookify/features/profile/domain/entities/user_statistic_entity.dart';

abstract class UserStatisticMapper {
  static UserStatisticEntity toEntity(UserStatisticModel model) {
    return UserStatisticEntity(
      favoriteRecipesCount: model.favoriteRecipesCount,
      createdRecipesCount: model.createdRecipesCount,
      publishedRecipesCount: model.publishedRecipesCount,
    );
  }
}
