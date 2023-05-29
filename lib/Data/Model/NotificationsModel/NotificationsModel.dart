import 'package:hive/hive.dart';
part 'NotificationsModel.g.dart';

@HiveType(typeId: 5)
class NotificationsModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String message;

  NotificationsModel({
    required this.id,
    required this.name,
    required this.message,
  });
}
