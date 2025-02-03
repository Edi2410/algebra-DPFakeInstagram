import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';

class PackageCardInfo extends ConsumerWidget {
  final PackageInfo package;
  final isCurrentPackage;

  const PackageCardInfo({
    super.key,
    required this.package,
    this.isCurrentPackage = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.all(isCurrentPackage ? 0.0 : 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isCurrentPackage ? Colors.green : Colors.transparent,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: [
              context.primaryColor,
              context.secondaryColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    package.getPackageName(),
                    style: context.textCardTitle,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      Text(
                        'Daily upload',
                        style: context.textCardSmall,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        package.getDailyUploadLimit().toString(),
                        style: context.textCardSubtitle,
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Column(
                    children: [
                      Text(
                        'Max spending',
                        style: context.textCardSmall,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        package.getMaxSpendingLimit().toString(),
                        style: context.textCardSubtitle,
                      ),
                    ],
                  ),
                  const VerticalDivider(
                    color: Colors.white,
                    thickness: 2,
                  ),
                  Column(
                    children: [
                      Text(
                        'Upload size',
                        style: context.textCardSmall,
                        softWrap: true,
                      ),
                      Text(
                        package.getUploadSizeLimit().toString(),
                        style: context.textCardSubtitle,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
