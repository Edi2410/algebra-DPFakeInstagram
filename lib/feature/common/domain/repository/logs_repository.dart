import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dp_project/core/error/failure.dart';
import 'package:dp_project/feature/logging/domain/entity/error_log.dart';
import 'package:dp_project/feature/logging/domain/entity/info_log.dart';

abstract interface class LogsRepository {
  Future<Either<Failure, List<ErrorLog>?>> getAllErrorLogs();

  Future<Either<Failure, List<InfoLog>?>> getAllInfoLogs();

  Future<Either<Failure, void>> addErrorLogs(final ErrorLog log);

  Future<Either<Failure, void>> addInfoLogs(final InfoLog log);


}
