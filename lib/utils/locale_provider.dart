import 'package:flutter/material.dart';

class LocaleProvider extends InheritedWidget {
  final Locale locale;
  final Function(Locale) setLocale;

  const LocaleProvider({
    Key? key,
    required this.locale,
    required this.setLocale,
    required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }

  static LocaleProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LocaleProvider>();
  }
}
