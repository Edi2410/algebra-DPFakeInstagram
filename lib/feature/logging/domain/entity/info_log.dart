import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/info_log.g.dart';

@JsonSerializable()
class InfoLog {
  final int? id;
  final String? uid;
  final String? email;
  final DateTime? date;
  final String? action;



  factory InfoLog.fromJson(Map<String, dynamic> json) =>
      _$InfoLogFromJson(json);

  InfoLog({required this.id, required this.uid, required this.email, required this.date, required this.action});

  Map<String, dynamic> toJson() => _$InfoLogToJson(this);
}
