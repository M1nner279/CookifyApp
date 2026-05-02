import 'package:cookify/features/profile/data/mappers/user_statistic_mapper.dart';
import 'package:cookify/features/profile/data/models/user_model.dart';
import 'package:cookify/features/profile/domain/entities/user_entity.dart';

abstract class UserMapper {
  static UserEntity toEntity(UserModel model) {
    return UserEntity(
      id: model.id.toString(),
      avatarUrl: model.avatarUrl,
      login: model.login,
      email: model.email,
      createdAt: DateTime.parse(model.createdAt),
      statistic: UserStatisticMapper.toEntity(model.statistic),
    );
  }
}
