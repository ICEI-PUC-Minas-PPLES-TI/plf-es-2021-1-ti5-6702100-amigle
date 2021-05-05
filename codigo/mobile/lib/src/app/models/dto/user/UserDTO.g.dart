// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) {
  return UserDTO(
    id: json['id'] as String,
    name: json['name'] as String,
    profilePic: json['profilePic'] as String,
    birthDate: json['birthDate'] as String,
    tags: (json['tags'] as List)
        ?.map((e) =>
            e == null ? null : TagDTO.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'profilePic': instance.profilePic,
      'birthDate': instance.birthDate,
      'tags': instance.tags,
    };
