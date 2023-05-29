import 'package:hive/hive.dart';
part 'HospitalModel.g.dart';


@HiveType(typeId: 4)
class HospitalModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int typeId;
  @HiveField(3)
  String latitude;
  @HiveField(4)
  String longtitude;
  @HiveField(5)
  int cityId;
  @HiveField(6)
  String hospitalType;
  @HiveField(7)
  String city;
  @HiveField(8)
  String address;
  @HiveField(9)
  int phoneNumber;

  HospitalModel(
      {required this.id,
      required this.name,
      required this.typeId,
      required this.latitude,
      required this.longtitude,
      required this.cityId,
      required this.hospitalType,
      required this.city,
      required this.address,
      required this.phoneNumber});

  factory HospitalModel.fromJson(Map<String, dynamic> json) => HospitalModel(
        id: json['ID'],
        name: json['name'],
        typeId: json['type_id'],
        latitude: json['latitude'],
        longtitude: json['longtitude'],
        cityId: json['city_id'],
        hospitalType: json['hospital_Type']['type'],
        city: json['city']['name']??"",
        address: json['address'],
        phoneNumber: json['phone_number'],
      );
}

class HospitalType {
  int id;
  String type;
  String desc;

  HospitalType({required this.id, required this.type, required this.desc});

  factory HospitalType.fromJson(Map<String, dynamic> json) => HospitalType(
        id: json['ID'],
        type: json['type'],
        desc: json['desc'],
      );
}

class City {
  int id;
  String name;
  String decs;

  City({required this.id, required this.name, required this.decs});

  factory City.fromJson(Map<String, dynamic> json) => City(
        id: json['ID'],
        name: json['name'],
        decs: json['decs'],
      );
}
