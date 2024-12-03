import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ipst_test_project/data/models/camera.dart';
import 'package:ipst_test_project/data/repositories/camera_repository.dart';
import 'package:ipst_test_project/routes/app_router.gr.dart';
import 'package:ipst_test_project/ui/localization/app_localizations.dart';
import 'package:ipst_test_project/ui/screens/error_screen.dart';
import 'package:ipst_test_project/ui/widgets/video_player_widget.dart';

@RoutePage()
class CameraScreen extends StatelessWidget {
  final String id;

  CameraScreen({required this.id});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return FutureBuilder<Camera?>(
      future: _getCameraById(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return ErrorScreen(errorMessage: '${localizations.cameraScreenIdError}${snapshot.error}');
        } else if (!snapshot.hasData) {
          return ErrorScreen(errorMessage: '${localizations.cameraScreenDataError}${snapshot.error}');
        } else {
          final camera = snapshot.data!;

          if (!camera.isActive) {
            Fluttertoast.showToast(
              msg: '${camera.name} - ${localizations.cameraDisabled}',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0,
            );
            context.pushRoute(const HomeRoute());
          }

          return Scaffold(
            appBar: AppBar(
              title: Text(localizations.cameraScreenTitle),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VideoPlayerWidget(
                          videoAsset: camera.url,
                          isPip: false,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${localizations.cameraScreenDateTitle}${camera.date}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<Camera?> _getCameraById(String id) async {
    final cameraRepository = CameraRepository();
    final camera = await cameraRepository.getCameraById(id);
    return camera;
  }
}
