// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TagDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TagDTO _$TagDTOFromJson(Map<String, dynamic> json) {
  return TagDTO(
    id: json['id'] as num,
    isApproved: json['isApproved'] as bool,
    name: json['name'] as String,
    category: json['category'] == null
        ? null
        : CategoryDTO.fromJson(json['category'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TagDTOToJson(TagDTO instance) => <String, dynamic>{
      'id': instance.id,
      'isApproved': instance.isApproved,
      'name': instance.name,
      'category': instance.category,
    };
