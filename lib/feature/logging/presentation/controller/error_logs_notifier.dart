
import 'package:dp_project/feature/logging/domain/entity/error_log.dart';
import 'package:dp_project/feature/logging/domain/usecase/logs_use_case.dart';
import 'package:dp_project/feature/logging/presentation/controller/state/error_logs_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';

class ErrorLogsNotifier extends Notifier<ErrorLogsState> {
  late final LogsUseCase _logsUseCase;
  List<ErrorLog>? errorLogs;

  @override
  ErrorLogsState build() {
    _logsUseCase = ref.read(logsUseCasesProvider);
    getAllErrorsLogs();
    return state;
  }

  Future<void> getAllErrorsLogs() async {
    state = const LoadingErrorLogs();
    final result = await _logsUseCase.getAllErrorLogs();
    result.fold(
      (failure) => state = ErrorErrorLogs(error: failure),
      (photos) {
        if (photos == null || photos.isEmpty) {
          state = const EmptyErrorLogs();
        } else {
          errorLogs = photos;
          state = SuccessErrorLogs(photos);
        }
      },
    );
  }

  Future<void> addErrorLog(String action, String error) async {
    final authUser = FirebaseAuth.instance.currentUser;

    final errorLog = ErrorLog(
      id: 1,
      uid: authUser == null ? 'anonymous' : authUser.uid,
      email: authUser == null ? 'anonymous' : authUser.email,
      date: DateTime.now(),
      action: action,
      error: error,
    );

    final result = await _logsUseCase.addErrorLogs(errorLog);
    result.fold(
      (failure) => state = ErrorErrorLogs(error: failure),
      (_) => getAllErrorsLogs(),
    );
  }
}
