import 'package:flutter/material.dart';


const _appBarTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w600);
const _titleTextStyle = TextStyle(fontSize: 32, fontWeight: FontWeight.bold);
const _standardTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w600);
const _descriptionTextStyle = TextStyle(fontSize: 14);
const _labelTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);
const _errorTextStyle = TextStyle(fontSize: 11, fontWeight: FontWeight.w600);
const _snackbarTextStyle = TextStyle(fontSize: 13, fontWeight: FontWeight.bold);
const _buttonTextStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const _cardTitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const _cardSubtitleTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
const _cardSmallTextStyle = TextStyle(
  fontSize: 10,
  fontWeight: FontWeight.normal,
  color: Colors.white,
);
const _stateTitleTextStyle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.bold,
);



extension CustomTextStyle on TextTheme {
  TextStyle get appBar => _appBarTextStyle;
  TextStyle get title => _titleTextStyle;
  TextStyle get standard => _standardTextStyle;
  TextStyle get description => _descriptionTextStyle;
  TextStyle get label => _labelTextStyle;
  TextStyle get error => _errorTextStyle;
  TextStyle get snackbar => _snackbarTextStyle;
  TextStyle get buttonText => _buttonTextStyle;
  TextStyle get cardTitle => _cardTitleTextStyle;
  TextStyle get cardSubtitle => _cardSubtitleTextStyle;
  TextStyle get cardSmall => _cardSmallTextStyle;
  TextStyle get stateTitle => _stateTitleTextStyle;
}