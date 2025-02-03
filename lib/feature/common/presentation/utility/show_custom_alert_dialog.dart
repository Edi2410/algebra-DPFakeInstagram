import 'package:flutter/material.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_alert_dialog.dart';

void showCustomAlertDialog(BuildContext context, final String message) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      Future.delayed(const Duration(seconds: 2), () => Navigator.of(context)
          .pop());
      return CustomAlertDialog(
        message: message,
      );
    },
  );
}
