import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/feature/common/presentation/screen/error_screen.dart';
import 'package:dp_project/feature/common/presentation/utility/package_utis.dart';
import 'package:dp_project/feature/profile/domain/entity/free_package.dart';
import 'package:dp_project/feature/profile/domain/entity/gold_package.dart';
import 'package:dp_project/feature/profile/domain/entity/package_info.dart';
import 'package:dp_project/feature/profile/domain/entity/pro_package.dart';
import 'package:dp_project/feature/common/presentation/screen/loading_screen.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_dropdown_field.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_package_card_info.dart';
import 'package:dp_project/feature/profile/presentation/controller/state/user_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_secondary_button.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/di.dart';

class ChangePackageScreen extends ConsumerStatefulWidget {
  const ChangePackageScreen({super.key});

  @override
  ConsumerState<ChangePackageScreen> createState() =>
      _ChangePackageScreenState();
}

class _ChangePackageScreenState extends ConsumerState<ChangePackageScreen> {
  @override
  Widget build(BuildContext context) {
    final userDataState = ref.watch(userDataNotifierProvider);

    return switch (userDataState) {
      LoadingUserData() => const LoadingScreen(),
      ErrorUserDataState() => const ErrorScreen(),
      SuccessUserData() => _buildChangePackagePage(context, userDataState),
    };
  }

  _buildChangePackagePage(BuildContext context, userDataState) {
    final formGroup = FormGroup({
      'chosenPackage': FormControl<PackageInfo>(
        validators: [Validators.required],
      ),
    });

    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
            title: "Change package", isBackButtonVisible: true),
        body: ReactiveForm(
          formGroup: formGroup,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      PackageCardInfo(
                          package: FreePackage(),
                          isCurrentPackage:
                              userDataState.user.packageInfo is FreePackage),
                      const SizedBox(height: 15),
                      PackageCardInfo(
                          package: ProPackage(FreePackage()),
                          isCurrentPackage:
                              userDataState.user.packageInfo is ProPackage),
                      const SizedBox(height: 15),
                      PackageCardInfo(
                          package: GoldPackage(FreePackage()),
                          isCurrentPackage:
                              userDataState.user.packageInfo is GoldPackage),
                      const SizedBox(height: 15),
                      Text(
                        'The changed package will be active after midnight!',
                        style: context.textDescription,
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(height: 15),
                      CustomDropdownField(
                        labelText: "Chose package",
                        items: [
                          DropdownMenuItem(
                            value: FreePackage(),
                            child: const Text('Free'),
                          ),
                          DropdownMenuItem(
                            value: ProPackage(FreePackage()),
                            child: const Text('Pro'),
                          ),
                          DropdownMenuItem(
                            value: GoldPackage(FreePackage()),
                            child: const Text('Gold'),
                          ),
                        ],
                        formControlName: 'chosenPackage',
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Please select a package',
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomSecondaryButton(
                          labelText: "Change",
                          onPressed: () {
                            if (formGroup.valid) {
                              ref
                                  .read(userDataNotifierProvider.notifier)
                                  .updatePackageInfo(
                                      userDataState.user,
                                      formGroup
                                          .control('chosenPackage')
                                          .value,
                                      context);
                            }
                          }),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
