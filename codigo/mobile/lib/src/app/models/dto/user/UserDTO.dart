import 'package:json_annotation/json_annotation.dart';

part 'UserDTO.g.dart';

@JsonSerializable()
class UserDTO {
  String uid;
  String name;
  String phone;
  String document;
  String businessName;
  String message;
  bool isAdmin;

  UserDTO(
      {this.uid,
      this.name,
      this.phone,
      this.document,
      this.businessName,
      this.message,
      this.isAdmin});

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
