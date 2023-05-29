import 'package:hive/hive.dart';
part 'LoginModel.g.dart';

@HiveType(typeId: 1)
class LoginModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String image_path;
  @HiveField(3)
  String password;

  LoginModel({
    required this.id,
    required this.name,
    required this.image_path,
    required this.password,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["ID"],
        name: json["name"] ?? "",
        image_path: json["image_path"] ?? "",
        password: json["password"] ?? "",
      );
}
