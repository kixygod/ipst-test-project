import 'package:equatable/equatable.dart';
import 'package:ipst_test_project/data/models/camera.dart';

abstract class CameraEvent extends Equatable {
  const CameraEvent();

  @override
  List<Object?> get props => [];
}

class CameraFetched extends CameraEvent {}

class CameraAdded extends CameraEvent {
  final Camera camera;

  const CameraAdded(this.camera);

  @override
  List<Object?> get props => [camera];
}

class CameraToggled extends CameraEvent {
  final int index;

  const CameraToggled(this.index);

  @override
  List<Object?> get props => [index];
}

class CameraUpdated extends CameraEvent {
  final int index;
  final Camera camera;

  const CameraUpdated(this.index, this.camera);

  @override
  List<Object?> get props => [index, camera];
}

class CameraDeleted extends CameraEvent {
  final int index;

  const CameraDeleted(this.index);

  @override
  List<Object?> get props => [index];
}
