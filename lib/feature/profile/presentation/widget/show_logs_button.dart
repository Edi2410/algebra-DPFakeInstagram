import 'package:dp_project/core/di.dart';
import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/profile/presentation/controller/state/user_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowLogsButton extends ConsumerStatefulWidget {
  const ShowLogsButton({super.key});

  @override
  ConsumerState<ShowLogsButton> createState() => _ShowLogsButtonState();
}

class _ShowLogsButtonState extends ConsumerState<ShowLogsButton> {
  @override
  Widget build(BuildContext context) {
    final customUserData = ref.watch(userDataNotifierProvider);

    return switch (customUserData) {
      LoadingUserData() => const SizedBox(),
      ErrorUserDataState() => const SizedBox(),
      SuccessUserData() => customUserData.user.isAdministrator
          ? CustomPrimaryButton(
              labelText: "Show Logs",
              onPressed: () {
                Navigator.of(context).pushNamed(RouteGenerator.logsScreen);
              },
            )
          : const SizedBox(),
    };
  }
}
