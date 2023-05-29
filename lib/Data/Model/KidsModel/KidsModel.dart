import 'package:hive/hive.dart';
part 'KidsModel.g.dart';

@HiveType(typeId: 2)
class KidsModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String pirth_date;
  @HiveField(3)
  String pirth_place;
  @HiveField(4)
  String blood;


  KidsModel({
    required this.id,
    required this.name,
    required this.pirth_date,
    required this.pirth_place,
    required this.blood,
  });

  factory KidsModel.fromJson(Map<String, dynamic> json) => KidsModel(
        id: json["ID"],
        name: json["name"] ?? "",
        pirth_date: json["pirth_date"] ?? "",
        pirth_place: json["pirth_place"] ?? "",
        blood: json["blood"] ?? "",
      );
}
