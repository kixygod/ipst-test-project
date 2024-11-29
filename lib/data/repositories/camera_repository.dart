import 'package:ipst_test_project/data/models/camera.dart';
import 'package:hive/hive.dart';

class CameraRepository {
  final Box<Camera> _cameraBox = Hive.box<Camera>('cameras');

  Future<List<Camera>> getCameras() async {
    return _cameraBox.values.toList();
  }

  Future<Camera?> getCameraById(String id) async {
    try {
      return _cameraBox.values.firstWhere(
        (camera) => camera.id == id,
      );
    } catch (e) {
      return null;
    }
  }

  Future<void> addCamera(Camera camera) async {
    await _cameraBox.add(camera);
  }

  Future<void> updateCamera(int index, Camera camera) async {
    await _cameraBox.putAt(index, camera);
  }

  Future<void> deleteCamera(int index) async {
    await _cameraBox.deleteAt(index);
  }
}
