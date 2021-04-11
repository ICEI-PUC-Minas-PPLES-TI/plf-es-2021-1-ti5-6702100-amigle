// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDTO _$UserDTOFromJson(Map<String, dynamic> json) {
  return UserDTO(
    uid: json['uid'] as String,
    name: json['name'] as String,
    phone: json['phone'] as String,
    document: json['document'] as String,
    businessName: json['businessName'] as String,
    message: json['message'] as String,
    isAdmin: json['isAdmin'] as bool,
  );
}

Map<String, dynamic> _$UserDTOToJson(UserDTO instance) => <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'phone': instance.phone,
      'document': instance.document,
      'businessName': instance.businessName,
      'message': instance.message,
      'isAdmin': instance.isAdmin,
    };
