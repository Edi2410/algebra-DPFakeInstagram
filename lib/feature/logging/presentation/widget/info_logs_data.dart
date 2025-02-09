import 'package:dp_project/core/di.dart';
import 'package:dp_project/feature/common/presentation/screen/empty_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/error_screen.dart';
import 'package:dp_project/feature/common/presentation/screen/loading_screen.dart';
import 'package:dp_project/feature/logging/presentation/controller/state/info_logs_state.dart';
import 'package:dp_project/feature/logging/presentation/widget/logs_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoLogsData extends ConsumerStatefulWidget {
  const InfoLogsData({super.key});

  @override
  ConsumerState<InfoLogsData> createState() => _InfoLogsDataState();
}

class _InfoLogsDataState extends ConsumerState<InfoLogsData> {
  @override
  Widget build(BuildContext context) {
    final infoLogsState = ref.watch(infoLogsNotifierProvider);

    return switch (infoLogsState) {
      EmptyInfoLogs() => const EmptyScreen(),
      ErrorInfoLogs() => const ErrorScreen(),
      LoadingInfoLogs() => const LoadingScreen(),
      SuccessInfoLogs() => _generateInfoDataScreen(context, infoLogsState),
    };
  }

  _generateInfoDataScreen(BuildContext context, SuccessInfoLogs infoLogsState) {
    return ListView.builder(
      itemCount: infoLogsState.logs.length,
      itemBuilder: (context, index) {
        final log = infoLogsState.logs[index];
        return LogCard(
          action: log.action,
          date: log.date,
          email: log.email,
        );
      },
    );
  }
}
