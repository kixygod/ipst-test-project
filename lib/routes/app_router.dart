import 'package:auto_route/auto_route.dart';
import 'package:ipst_test_project/ui/screens/home_screen.dart';
import 'package:ipst_test_project/ui/screens/camera_screen.dart';
import 'package:ipst_test_project/routes/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: CameraRoute.page, path: '/camera/:id'),
        AutoRoute(page: CameraForm.page, path: '/camera_form'),
      ];

  @override
  List<AutoRouteGuard> get guards => [];
}
