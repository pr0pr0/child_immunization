import 'package:hive/hive.dart';
part 'NotifyModel.g.dart';

@HiveType(typeId: 3)
class NotifyModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String notify;
  @HiveField(2)
  String desc;

  NotifyModel({
    required this.id,
    required this.notify,
    required this.desc,
  });

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
        id: json["ID"],
        notify: json["name"] ?? "",
        desc: json["desc"] ?? "",
      );
}
