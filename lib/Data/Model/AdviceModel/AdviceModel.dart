import 'package:hive/hive.dart';
part 'AdviceModel.g.dart';

@HiveType(typeId: 0)
class AdviceModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String advice;
  @HiveField(2)
  String desc;

  AdviceModel({
    required this.id,
    required this.advice,
    required this.desc,
  });

  factory AdviceModel.fromJson(Map<String, dynamic> json) => AdviceModel(
        id: json["ID"],
        advice: json["name"] ?? "",
        desc: json["desc"] ?? "",
      );
}
