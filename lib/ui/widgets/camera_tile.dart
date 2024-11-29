import 'package:flutter/material.dart';
import 'package:ipst_test_project/blocs/camera/camera_state.dart';
import 'package:ipst_test_project/data/models/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipst_test_project/blocs/camera/camera_bloc.dart';
import 'package:ipst_test_project/blocs/camera/camera_event.dart';
import 'package:auto_route/auto_route.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:ipst_test_project/routes/app_router.gr.dart';
import 'package:ipst_test_project/ui/localization/app_localizations.dart';

class CameraTile extends StatelessWidget {
  final Camera camera;
  final int index;
  final bool isEditing;

  CameraTile({
    required this.camera,
    required this.index,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return BlocBuilder<CameraBloc, CameraState>(
      builder: (context, state) {
        if (state is CameraLoaded) {
          final updatedCamera = state.cameras[index];

          return Card(
            elevation: 2,
            child: GestureDetector(
              onTap: () {
                if (!updatedCamera.isActive) {
                  Fluttertoast.showToast(
                    msg: localizations.cameraDisabled,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    fontSize: 14.0,
                  );
                } else {
                  context.pushRoute(
                    CameraRoute(id: updatedCamera.id),
                  );
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12.0),
                      topRight: Radius.circular(12.0),
                    ),
                    child: Image.asset('assets/350x150.png'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      updatedCamera.name,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: Icon(updatedCamera.isActive ? Icons.toggle_on : Icons.toggle_off),
                    color: updatedCamera.isActive ? Colors.green : const Color.fromARGB(115, 18, 16, 16),
                    onPressed: () {
                      context.read<CameraBloc>().add(CameraToggled(index));
                    },
                  ),
                  if (isEditing)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            final deepLink = 'https://com.example.ipst_test_project/camera/${updatedCamera.id}';

                            Clipboard.setData(ClipboardData(text: deepLink)).then((_) {
                              Fluttertoast.showToast(
                                msg: localizations.cameraUrlCopied,
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                fontSize: 14.0,
                              );
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            context.read<CameraBloc>().add(CameraDeleted(index));
                            Fluttertoast.showToast(
                              msg: localizations.cameraDeleted,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              fontSize: 14.0,
                            );
                          },
                        ),
                      ],
                    )
                ],
              ),
            ),
          );
        } else if (state is CameraLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CameraError) {
          return Center(child: Text('${localizations.errorScreenTitle}${state.message}'));
        }
        return const SizedBox();
      },
    );
  }
}
