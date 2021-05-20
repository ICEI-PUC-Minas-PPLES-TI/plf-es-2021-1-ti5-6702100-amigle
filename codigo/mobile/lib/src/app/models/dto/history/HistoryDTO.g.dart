// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'HistoryDTO.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryDTO _$HistoryDTOFromJson(Map<String, dynamic> json) {
  return HistoryDTO(
    id: json['id'] as num,
    guestUserName: json['guestUserName'] as String,
    endDate: json['endDate'] as String,
    startDate: json['startDate'] as String,
  );
}

Map<String, dynamic> _$HistoryDTOToJson(HistoryDTO instance) =>
    <String, dynamic>{
      'id': instance.id,
      'guestUserName': instance.guestUserName,
      'endDate': instance.endDate,
      'startDate': instance.startDate,
    };
