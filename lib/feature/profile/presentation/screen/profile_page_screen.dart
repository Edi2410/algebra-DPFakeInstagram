import 'package:dp_project/core/route_generator.dart';
import 'package:dp_project/feature/auth/presentation/controller/state/auth_state.dart';
import 'package:dp_project/feature/common/presentation/screen/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dp_project/core/style/style_extensions.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_app_bar.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_primary_button.dart';
import 'package:dp_project/feature/common/presentation/widget/custom_secondary_button.dart';

import '../../../../core/di.dart';

class ProfilePageScreen extends ConsumerStatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  ConsumerState<ProfilePageScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfilePageScreen> {
  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);

    return switch (authState) {
      LoadingAuth() => const LoadingScreen(),
      UnauthenticatedAuthState() => _buildLoginScreen(context),
      AuthenticatedAuth() => _buildProfilePage(context, authState),
    };
  }

  _buildProfilePage(BuildContext context, authState) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Profile"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 50),
                    CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                        authState.authUser.photoURL != null &&
                                authState.authUser.photoURL!.isNotEmpty
                            ? authState.authUser.photoURL!
                            : 'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(authState.authUser.displayName ?? '-',
                        style: context.textTitle),
                    const SizedBox(height: 10),
                    Text(
                      authState.authUser.email!,
                      style: context.textStandard,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomSecondaryButton(
                        labelText: "Change package",
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.changePackageScreen);
                        }),
                    const SizedBox(height: 20),
                    CustomPrimaryButton(
                        labelText: "Sign out",
                        onPressed: () {
                          ref
                              .read(authNotifierProvider.notifier)
                              .signOut(context);
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildLoginScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(title: "Profile"),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 50),
                    const CircleAvatar(
                      radius: 75,
                      backgroundImage: NetworkImage(
                        'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png',
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('-', style: context.textTitle),
                    const SizedBox(height: 10),
                    Text(
                      '-',
                      style: context.textStandard,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    CustomPrimaryButton(
                        labelText: "Login",
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(RouteGenerator.signInScreen);
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
