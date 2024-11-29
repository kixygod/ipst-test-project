import 'package:flutter/material.dart';
import 'en.dart';
import 'ru.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String translate(String key) {
    if (locale.languageCode == 'ru') {
      return Ru.values[key] ?? key;
    } else {
      return En.values[key] ?? key;
    }
  }

  String get cameraFormName => translate('camera-form-name');
  String get cameraFormNameError => translate('camera-form-name-error');
  String get cameraFormUrl => translate('camera-form-url');
  String get cameraFormUrlError => translate('camera-form-url-error');
  String get cameraFormUrlValidationError => translate('camera-form-url-validation-error');
  String get cameraFormEnabled => translate('camera-form-enabled');
  String get cameraFormAdd => translate('camera-form-add');

  String get cameraBlocDataError => translate('camera-bloc-data-error');
  String get cameraBlocAddError => translate('camera-bloc-add-error');

  String get cameraScreenDataError => translate('camera-screen-data-error');
  String get cameraScreenIdError => translate('camera-screen-id-error');
  String get cameraScreenTitle => translate('camera-screen-title');
  String get cameraScreenDateTitle => translate('camera-screen-date-title');

  String get errorScreenTitle => translate('error-screen-title');

  String get back => translate('back');

  String get homeScreenTitle => translate('home-screen-title');
  String get homeScreenNoObjects => translate('home-screen-no-objects');

  String get noData => translate('no-data');
  String get cameraDisabled => translate('camera-disabled');
  String get cameraUrlCopied => translate('camera-url-coppied');
  String get cameraDeleted => translate('camera-deleted');
}
