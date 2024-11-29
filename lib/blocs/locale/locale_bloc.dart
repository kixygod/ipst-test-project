import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class LocaleState {
  final Locale locale;
  LocaleState(this.locale);
}

abstract class LocaleEvent {}

class LocaleChanged extends LocaleEvent {
  final Locale newLocale;
  LocaleChanged(this.newLocale);
}

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleState(_getDeviceLocale())) {
    on<LocaleChanged>((event, emit) {
      // Обновляем локаль
      emit(LocaleState(event.newLocale));
    });
  }

  static Locale _getDeviceLocale() {
    final deviceLocale = WidgetsBinding.instance.window.locale;
    if (deviceLocale.languageCode == 'ru') {
      return Locale('ru', 'RU');
    } else {
      return Locale('en', 'US');
    }
  }
}
