import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/logging/domain/entity/error_log.dart';

sealed class ErrorLogsState {
  const ErrorLogsState();
}

class LoadingErrorLogs extends ErrorLogsState {
  const LoadingErrorLogs();
}

class ErrorErrorLogs extends ErrorLogsState {
  final Failure? error;

  const ErrorErrorLogs({this.error});
}

class SuccessErrorLogs extends ErrorLogsState {
  final List<ErrorLog> logs;

  const SuccessErrorLogs(this.logs);
}

class EmptyErrorLogs extends ErrorLogsState {
  const EmptyErrorLogs();
}
