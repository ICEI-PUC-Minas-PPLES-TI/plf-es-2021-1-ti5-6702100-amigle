import 'package:hive/hive.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 0)
class UserEntity extends HiveObject {
  @HiveField(0)
  String uid;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;

  @HiveField(3)
  String document;

  @HiveField(4)
  String businessName;

  @HiveField(5)
  String message;

  @HiveField(6)
  bool isAdmin;

  @HiveField(7)
  bool logged = false;
}
