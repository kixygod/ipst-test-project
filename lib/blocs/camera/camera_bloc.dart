import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ipst_test_project/data/models/camera.dart';
import 'package:ipst_test_project/data/repositories/camera_repository.dart';
import 'package:ipst_test_project/ui/localization/app_localizations.dart';
import 'camera_event.dart';
import 'camera_state.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraRepository cameraRepository;
  final BuildContext context;

  CameraBloc(this.cameraRepository, this.context) : super(CameraLoading()) {
    on<CameraFetched>(_onCameraFetched);
    on<CameraAdded>(_onCameraAdded);
    on<CameraToggled>(_onCameraToggled);
    on<CameraUpdated>(_onCameraUpdated);
    on<CameraDeleted>(_onCameraDeleted);
  }

  Future<void> _onCameraFetched(CameraFetched event, Emitter<CameraState> emit) async {
    emit(CameraLoading());
    try {
      final cameras = await cameraRepository.getCameras();
      emit(CameraLoaded(cameras));
    } catch (e) {
      final errorMessage = AppLocalizations.of(context).cameraBlocDataError;
      emit(CameraError(errorMessage));
    }
  }

  Future<void> _onCameraAdded(CameraAdded event, Emitter<CameraState> emit) async {
    try {
      await cameraRepository.addCamera(event.camera);
      add(CameraFetched());
    } catch (e) {
      final errorMessage = AppLocalizations.of(context).cameraBlocAddError;
      emit(CameraError(errorMessage));
    }
  }

  Future<void> _onCameraToggled(CameraToggled event, Emitter<CameraState> emit) async {
    final currentState = state;
    if (currentState is CameraLoaded) {
      final cameras = List<Camera>.from(currentState.cameras);
      cameras[event.index] = cameras[event.index].copyWith(isActive: !cameras[event.index].isActive);
      print("Updating camera at index ${event.index}");
      await cameraRepository.updateCamera(event.index, cameras[event.index]);
      emit(CameraLoaded(cameras));
    }
  }

  Future<void> _onCameraUpdated(CameraUpdated event, Emitter<CameraState> emit) async {
    await cameraRepository.updateCamera(event.index, event.camera);
    add(CameraFetched());
  }

  Future<void> _onCameraDeleted(CameraDeleted event, Emitter<CameraState> emit) async {
    await cameraRepository.deleteCamera(event.index);
    add(CameraFetched());
  }
}
