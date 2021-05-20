import 'package:json_annotation/json_annotation.dart';

part 'HistoryDTO.g.dart';

@JsonSerializable()
class HistoryDTO {
  num id;
  String guestUserName;
  String endDate;
  String startDate;

  HistoryDTO({this.id, this.guestUserName, this.endDate, this.startDate});

  factory HistoryDTO.fromJson(Map<String, dynamic> json) =>
      _$HistoryDTOFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryDTOToJson(this);
}
