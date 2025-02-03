import 'package:flutter/material.dart';
import 'package:dp_project/core/style/style_extensions.dart';


enum DialogType { success, error }

class CustomAlertDialog extends StatelessWidget {
  final String message;

  const CustomAlertDialog({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: context.backgroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: context.secondaryColor,
          width: 5,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      alignment: Alignment.bottomCenter,

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              color: context.secondaryColor,
              size: 24,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: context.textStandard,
                softWrap: true,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
