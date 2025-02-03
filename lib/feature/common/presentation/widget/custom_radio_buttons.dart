import 'package:dp_project/core/style/style_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CustomRadioButtons extends HookConsumerWidget {
  final List<String> items;
  final String formControlName;

  const CustomRadioButtons(
      {super.key, required this.items, required this.formControlName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          for (var item in items)
            ReactiveRadioListTile(
              value: item,
              title: Text(item),
              formControlName: formControlName,
              activeColor: context.primaryColor,
              hoverColor: context.secondaryColor,
            ),
        ],
      ),
    );
  }
}
