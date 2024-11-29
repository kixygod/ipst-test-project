import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipst_test_project/blocs/camera/camera_bloc.dart';
import 'package:ipst_test_project/blocs/locale/locale_bloc.dart';
import 'package:ipst_test_project/data/repositories/camera_repository.dart';
import 'package:ipst_test_project/routes/app_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ipst_test_project/data/models/camera.dart';
import 'package:flutter_in_app_pip/flutter_in_app_pip.dart';
import 'package:app_links/app_links.dart';
import 'package:ipst_test_project/routes/app_router.gr.dart';
import 'package:ipst_test_project/ui/localization/localization_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ipst_test_project/utils/locale_provider.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CameraAdapter());
  await Hive.openBox<Camera>('cameras');

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CameraBloc(CameraRepository(), context)),
        BlocProvider(create: (context) => LocaleBloc()),
      ],
      child: PiPMaterialApp(
        home: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _appLinks = AppLinks();
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    _subscribeToDeepLinks();
  }

  void _subscribeToDeepLinks() {
    _appLinks.uriLinkStream.listen((uri) {
      print(uri);
      _handleDeepLink(uri);
    });
  }

  void _handleDeepLink(Uri uri) {
    if (uri.scheme == 'https' && uri.host == 'com.example.ipst_test_project') {
      final id = uri.pathSegments.isNotEmpty ? uri.pathSegments[1] : '';
      _appRouter.push(CameraRoute(id: id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleBloc, LocaleState>(
      builder: (context, state) {
        return LocaleProvider(
          locale: state.locale,
          setLocale: (newLocale) {
            context.read<LocaleBloc>().add(LocaleChanged(newLocale));
          },
          child: MaterialApp.router(
            routerDelegate: _appRouter.delegate(),
            routeInformationParser: _appRouter.defaultRouteParser(),
            builder: (context, child) {
              return child ?? Container();
            },
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ru', 'RU'),
            ],
            locale: state.locale,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              AppLocalizationsDelegate(),
              GlobalCupertinoLocalizations.delegate,
            ],
          ),
        );
      },
    );
  }
}
