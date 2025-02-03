import 'package:flutter/material.dart';
import 'package:dp_project/core/style/style_extensions.dart';

class CustomPrimaryButton extends StatelessWidget {
  final GlobalKey<FormState>? formKey;
  final String labelText;
  final void Function()? onPressed;

  const CustomPrimaryButton({
    super.key,
    this.formKey,
    required this.labelText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.primaryColor.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.zero,
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
              context.primaryColor,
                context.secondaryColor,
              ],
            ),

          ),
          child: Container(
            height: 50.0,
            alignment: Alignment.center,
            child: Text(
              labelText.toUpperCase(),
              textAlign: TextAlign.center,
              style: context.textButton,
            ),
          ),
        ),
      ),
    );
  }
}
