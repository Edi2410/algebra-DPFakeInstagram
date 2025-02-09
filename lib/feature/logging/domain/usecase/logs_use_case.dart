import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/logging/domain/entity/error_log.dart';
import 'package:dp_project/feature/logging/domain/entity/info_log.dart';
import 'package:dp_project/feature/common/domain/repository/logs_repository.dart';

class LogsUseCase {
  final LogsRepository _logsRepository;

  const LogsUseCase(this._logsRepository);

  Future<Either<Failure, void>> addErrorLogs(ErrorLog log) async {
    return _logsRepository.addErrorLogs(log);
  }

  Future<Either<Failure, void>> addInfoLogs(InfoLog log) async {
    return _logsRepository.addInfoLogs(log);
  }

  Future<Either<Failure, List<ErrorLog>?>> getAllErrorLogs() async {
    return _logsRepository.getAllErrorLogs();
  }

  Future<Either<Failure, List<InfoLog>?>> getAllInfoLogs() async {
    return _logsRepository.getAllInfoLogs();
  }
}
