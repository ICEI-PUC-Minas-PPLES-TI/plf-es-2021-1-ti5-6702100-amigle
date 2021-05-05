import 'package:amigleapp/src/app/models/dto/tags/TagDTO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'UserDTO.g.dart';

@JsonSerializable()
class UserDTO {
  String id;
  String name;
  String profilePic;
  String birthDate;
  List<TagDTO> tags;

  UserDTO({
    this.id,
    this.name,
    this.profilePic,
    this.birthDate,
    this.tags,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) =>
      _$UserDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UserDTOToJson(this);
}
