// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:ipst_test_project/ui/screens/camera_screen.dart' as _i2;
import 'package:ipst_test_project/ui/screens/home_screen.dart' as _i3;
import 'package:ipst_test_project/ui/widgets/camera_form.dart' as _i1;

/// generated route for
/// [_i1.CameraForm]
class CameraForm extends _i4.PageRouteInfo<void> {
  const CameraForm({List<_i4.PageRouteInfo>? children})
      : super(
          CameraForm.name,
          initialChildren: children,
        );

  static const String name = 'CameraForm';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return _i1.CameraForm();
    },
  );
}

/// generated route for
/// [_i2.CameraScreen]
class CameraRoute extends _i4.PageRouteInfo<CameraRouteArgs> {
  CameraRoute({
    required String id,
    List<_i4.PageRouteInfo>? children,
  }) : super(
          CameraRoute.name,
          args: CameraRouteArgs(id: id),
          initialChildren: children,
        );

  static const String name = 'CameraRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CameraRouteArgs>();
      return _i2.CameraScreen(id: args.id);
    },
  );
}

class CameraRouteArgs {
  const CameraRouteArgs({required this.id});

  final String id;

  @override
  String toString() {
    return 'CameraRouteArgs{id: $id}';
  }
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i4.PageInfo page = _i4.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}
