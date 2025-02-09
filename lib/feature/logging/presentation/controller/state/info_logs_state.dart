
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/logging/domain/entity/info_log.dart';

sealed class InfoLogsState {
  const InfoLogsState();
}

class LoadingInfoLogs extends InfoLogsState {
  const LoadingInfoLogs();
}

class ErrorInfoLogs extends InfoLogsState {
  final Failure? error;

  const ErrorInfoLogs({this.error});
}

class SuccessInfoLogs extends InfoLogsState {
  final List<InfoLog> logs;

  const SuccessInfoLogs(this.logs);
}

class EmptyInfoLogs extends InfoLogsState {
  const EmptyInfoLogs();
}
