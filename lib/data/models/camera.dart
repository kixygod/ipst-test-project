import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'camera.g.dart';

@HiveType(typeId: 1)
class Camera {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String url;

  @HiveField(3)
  bool isActive;

  @HiveField(4)
  final String date;

  Camera({
    required this.id,
    required this.name,
    required this.url,
    this.isActive = false,
    required this.date,
  });

  Camera copyWith({
    String? id,
    String? name,
    String? url,
    bool? isActive,
    String? date,
  }) {
    return Camera(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      isActive: isActive ?? this.isActive,
      date: date ?? this.date,
    );
  }

  static String generateId() {
    var uuid = Uuid();
    return uuid.v4();
  }
}
