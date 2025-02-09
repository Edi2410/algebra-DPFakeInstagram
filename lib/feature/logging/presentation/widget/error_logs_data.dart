import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/screen/empty_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/error_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/loading_screen.dart';
import 'package:dp_project/feature/logging/presentation/controller/state/error_logs_state.dart';
import 'package:dp_project/feature/logging/presentation/widget/logs_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorLogsData extends ConsumerStatefulWidget {
  const ErrorLogsData({super.key});

  @override
  ConsumerState<ErrorLogsData> createState() => _ErrorLogsDataState();
}

class _ErrorLogsDataState extends ConsumerState<ErrorLogsData> {
  @override
  Widget build(BuildContext context) {
    final errorLogsState = ref.watch(errorLogsNotifierProvider);

    return switch (errorLogsState) {
      EmptyErrorLogs() => const EmptyScreen(),
      ErrorErrorLogs() => const ErrorScreen(),
      LoadingErrorLogs() => const LoadingScreen(),
      SuccessErrorLogs() => _generateInfoDataScreen(context, errorLogsState),
    };
  }

  _generateInfoDataScreen(
      BuildContext context, SuccessErrorLogs errorLogsState) {
    return ListView.builder(
      itemCount: errorLogsState.logs.length,
      itemBuilder: (context, index) {
        final log = errorLogsState.logs[index];
        return LogCard(
          action: log.action,
          date: log.date,
          email: log.email,
        );
      },
    );
  }
}
