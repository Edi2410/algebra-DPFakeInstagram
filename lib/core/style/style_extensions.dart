
import 'package:flutter/material.dart';
import 'package:dp_project/core/style/text_style.dart';

import 'colors.dart';

extension StyleContextExtension on BuildContext {
  TextStyle get textAppBar => Theme.of(this).textTheme.appBar;
  TextStyle get textTitle => Theme.of(this).textTheme.title;
  TextStyle get textStandard => Theme.of(this).textTheme.standard;
  TextStyle get textStandardLight => Theme.of(this).textTheme.standard.copyWith(fontWeight: FontWeight.normal);
  TextStyle get textDescription => Theme.of(this).textTheme.description;
  TextStyle get textLabel => Theme.of(this).textTheme.label;
  TextStyle get textError => Theme.of(this).textTheme.error.copyWith(color: errorColorLight);
  TextStyle get textSnackbar => Theme.of(this).textTheme.snackbar.copyWith(color: textColorLight);
  TextStyle get textButton => Theme.of(this).textTheme.buttonText;
  TextStyle get textCardTitle => Theme.of(this).textTheme.cardTitle;
  TextStyle get textCardSubtitle => Theme.of(this).textTheme.cardSubtitle;
  TextStyle get textCardSmall => Theme.of(this).textTheme.cardSmall;
  TextStyle get textHighlightStandard => Theme.of(this).textTheme.standard
      .copyWith(color: secondaryColor);
  TextStyle get textStateTitle => Theme.of(this).textTheme.stateTitle;

  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get primaryColor => Theme.of(this).extension<AppColors>()!.primary!;
  Color get textColor => Theme.of(this).extension<AppColors>()!.text!;
  Color get secondaryColor => Theme.of(this).extension<AppColors>()!.secondary!;
  Color get shadowColor => Theme.of(this).extension<AppColors>()!.shadow!;
  Color get errorColor => Theme.of(this).extension<AppColors>()!.error!;
}
