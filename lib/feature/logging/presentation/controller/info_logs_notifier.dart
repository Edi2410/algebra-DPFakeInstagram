import 'package:dp_project/feature/logging/domain/entity/info_log.dart';
import 'package:dp_project/feature/logging/domain/usecase/logs_use_case.dart';
import 'package:dp_project/feature/logging/presentation/controller/state/info_logs_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/di.dart';

class InfoLogsNotifier extends Notifier<InfoLogsState> {
  late final LogsUseCase _logsUseCase;
  late List<InfoLog>? infoLoggg;

  @override
  InfoLogsState build() {
    _logsUseCase = ref.read(logsUseCasesProvider);

    return state;
  }

  Future<void> getAllInfoLogs() async {
    state = const LoadingInfoLogs();
    final result = await _logsUseCase.getAllInfoLogs();
    result.fold(
      (failure) => state = ErrorInfoLogs(error: failure),
      (logs) {
        if (logs == null || logs.isEmpty) {
          state = const EmptyInfoLogs();
        } else {
          infoLoggg = logs;
          state = SuccessInfoLogs(logs);
        }
      },
    );
  }

  Future<void> addInfoLog(String action) async {
    final authUser = FirebaseAuth.instance.currentUser;

    final infoL = InfoLog(
      id: 1,
      uid: authUser == null ? 'anonymous' : authUser.uid,
      email: authUser == null ? 'anonymous' : authUser.email,
      date: DateTime.now(),
      action: action,
    );

    final result = await _logsUseCase.addInfoLogs(infoL);
    result.fold(
      (failure) => state = ErrorInfoLogs(error: failure),
      (_) => getAllInfoLogs(),
    );
  }
}
