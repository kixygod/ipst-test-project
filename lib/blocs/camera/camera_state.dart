import 'package:equatable/equatable.dart';
import 'package:ipst_test_project/data/models/camera.dart';

abstract class CameraState extends Equatable {
  const CameraState();

  @override
  List<Object?> get props => [];
}

class CameraLoading extends CameraState {}

class CameraLoaded extends CameraState {
  final List<Camera> cameras;
  CameraLoaded(this.cameras);

  @override
  List<Object?> get props => [cameras];
}

class CameraError extends CameraState {
  final String message;
  CameraError(this.message);

  @override
  List<Object?> get props => [message];
}
