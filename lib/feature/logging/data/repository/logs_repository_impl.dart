import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/logging/data/api/logs_api.dart';
import 'package:dp_project/feature/logging/domain/entity/error_log.dart';
import 'package:dp_project/feature/logging/domain/entity/info_log.dart';
import 'package:dp_project/feature/common/domain/repository/logs_repository.dart';

class LogsRepositoryImpl implements LogsRepository {
  final LogsSqlApi _api;

  const LogsRepositoryImpl(this._api);

  @override
  Future<Either<Failure, void>> addErrorLogs(ErrorLog log) async {
    try {
      _api.insertErrorLogs(log);
      return const Right(null);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addInfoLogs(InfoLog log) async {
    try {
      _api.insertInfoLogs(log);
      return const Right(null);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ErrorLog>?>> getAllErrorLogs() async {
    try {
      final errorLogs = await _api.getAllErrorLogs();
      return Right(errorLogs);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<InfoLog>?>> getAllInfoLogs() async {
    try {
      final infoLogs = await _api.getAllInfoLogs();
      return Right(infoLogs);
    } catch (e) {
      return Left(GeneralError(message: e.toString()));
    }
  }
}
