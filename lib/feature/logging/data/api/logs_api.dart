import 'package:dp_project/core/sql_db.dart';
import 'package:dp_project/feature/logging/domain/entity/error_log.dart';
import 'package:dp_project/feature/logging/domain/entity/info_log.dart';

class LogsSqlApi {
  final SqlDb _sqlDb;

  LogsSqlApi(this._sqlDb);

  Future<void> insertErrorLogs(final ErrorLog log) async {
    final database = await _sqlDb.db;

    await database.insert(
      'ErrorLogs',
      {
        'uid': log.uid,
        'email': log.email,
        'error': log.error,
        'action': log.action,
      },
    );
  }

  Future<void> insertInfoLogs(final InfoLog log) async {
    final database = await _sqlDb.db;

    await database.insert(
      'InfoLogs',
      {
        'uid': log.uid,
        'email': log.email,
        'action': log.action,
      },
    );
  }

  Future<List<ErrorLog>> getAllErrorLogs() async {
    final database = await _sqlDb.db;
    List<ErrorLog> errorLogs = [];
    var errorLogsSql = await database.query(
      'ErrorLogs',
      orderBy: 'date DESC',
      limit: 50,
    );

    if (errorLogsSql.isNotEmpty) {
      errorLogsSql
          .map((log) => errorLogs.add(ErrorLog(
              id: int.parse(log['id'].toString()),
              uid: log['uid'].toString(),
              date:
                  DateTime.parse(log['date'].toString().replaceFirst(' ', 'T')),
              action: log['action'].toString(),
              error: log['error'].toString(),
              email: log['email'].toString())))
          .toList();
    }

    return errorLogs;
  }

  Future<List<InfoLog>> getAllInfoLogs() async {
    final database = await _sqlDb.db;
    List<InfoLog> infoLogs = [];
    var infoLogsSql = await database.query(
      'InfoLogs',
      orderBy: 'date DESC',
      limit: 50,
    );

    if (infoLogsSql.isNotEmpty) {
      infoLogsSql
          .map((log) => infoLogs.add(InfoLog(
              id: int.parse(log['id'].toString()),
              uid: log['uid'].toString(),
              date:
                  DateTime.parse(log['date'].toString().replaceFirst(' ', 'T')),
              action: log['action'].toString(),
              email: log['email'].toString())))
          .toList();
    }

    return infoLogs;
  }
}
