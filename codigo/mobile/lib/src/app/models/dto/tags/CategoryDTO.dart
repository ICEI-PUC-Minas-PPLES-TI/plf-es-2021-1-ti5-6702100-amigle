import 'package:json_annotation/json_annotation.dart';

part 'CategoryDTO.g.dart';

@JsonSerializable()
class CategoryDTO {
  String name;
  num id;
  bool selected = false;

  CategoryDTO({this.name, this.id});

  factory CategoryDTO.fromJson(Map<String, dynamic> json) =>
      _$CategoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryDTOToJson(this);
}
