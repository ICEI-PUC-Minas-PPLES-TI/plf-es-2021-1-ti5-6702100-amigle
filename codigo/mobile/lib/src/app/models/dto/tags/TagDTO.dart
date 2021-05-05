import 'package:amigleapp/src/app/models/dto/tags/CategoryDTO.dart';
import 'package:json_annotation/json_annotation.dart';

part 'TagDTO.g.dart';

@JsonSerializable()
class TagDTO {
  num id;
  bool isApproved;
  String name;
  CategoryDTO category;

  TagDTO({this.id, this.isApproved, this.name, this.category});

  factory TagDTO.fromJson(Map<String, dynamic> json) => _$TagDTOFromJson(json);

  Map<String, dynamic> toJson() => _$TagDTOToJson(this);
}

enum TypeSearchTag { NEW, MY, SUGGESTION }
