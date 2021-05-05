// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CategoryDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryDTO _$CategoryDTOFromJson(Map<String, dynamic> json) {
  return CategoryDTO(
    name: json['name'] as String,
    id: json['id'] as num,
  )..selected = json['selected'] as bool;
}

Map<String, dynamic> _$CategoryDTOToJson(CategoryDTO instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'selected': instance.selected,
    };
