import 'package:hive/hive.dart';
part 'VaccineModel.g.dart';

@HiveType(typeId: 6)
class VaccineModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int daysToTake;
  @HiveField(3)
  String desc;
  @HiveField(4)
  String dose;
  @HiveField(5)
  bool isTaken;

  VaccineModel({
    required this.id,
    required this.name,
    required this.daysToTake,
    required this.desc,
    required this.dose,
    required this.isTaken,
  });

  factory VaccineModel.fromJson(Map<String, dynamic> json) => VaccineModel(
        id: json["ID"],
        name: json["name"] ?? "",
        daysToTake: json["days_to_take"] ?? "",
        desc: json["desc"] ?? "",
        dose: json["dose"]["name"] ?? "",
        isTaken: json["isTaken"]?? false,
      );
}
