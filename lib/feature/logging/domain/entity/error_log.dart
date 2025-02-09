import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/error_log.g.dart';

@JsonSerializable()
class ErrorLog {
  final int? id;
  final String? uid;
  final String? email;
  final DateTime? date;
  final String? action;
  final String? error;


  factory ErrorLog.fromJson(Map<String, dynamic> json) =>
      _$ErrorLogFromJson(json);

  ErrorLog({required this.id, required this.uid, required this.email, required this.date, required this.action, required this.error});

  Map<String, dynamic> toJson() => _$ErrorLogToJson(this);
}
