import 'package:flutter/material.dart';
import 'package:dp_project/core/style/style_extensions.dart';


class CustomAppBar extends StatelessWidget implements
    PreferredSizeWidget {
  final String title;
  final bool isBackButtonVisible;
  final bool isTitleCentered;
  final Color shadowColor;
  final double elevation;

  const CustomAppBar({
    super.key,
    required this.title,
    this.isBackButtonVisible = false,
    this.isTitleCentered = false,
    this.shadowColor = Colors.black,
    this.elevation = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: context.backgroundColor,
      surfaceTintColor: context.backgroundColor,
      automaticallyImplyLeading: isBackButtonVisible,
      centerTitle: isTitleCentered,
      shadowColor: shadowColor.withOpacity(0.5),
      elevation: elevation,
      title: Text(
        title,
        style: context.textAppBar.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
