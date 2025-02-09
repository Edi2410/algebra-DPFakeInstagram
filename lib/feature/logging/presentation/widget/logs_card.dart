import 'package:dp_project/core/style/style_extensions.dart';
import 'package:flutter/material.dart';

class LogCard extends StatelessWidget {
  final String? action;
  final String? email;
  final DateTime? date;

  const LogCard({
    Key? key,
    required this.action,
    required this.email,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        tileColor: Colors.white,
        title: Text(action ?? 'No Action', style: context.textTitle.copyWith
          (fontSize: 16)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: ${email ?? 'No Email'}',
                style: context.textDescription),
            Text(
                'Date: ${date != null ? date!.toLocal().toString() : 'No '
                    'Date'}',
                style: context.textDescription),
          ],
        ),
      ),
    );
  }
}
