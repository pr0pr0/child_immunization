import 'package:child_immunization/Data/Model/AdviceModel/AdviceModel.dart';
import 'package:child_immunization/Data/Model/HospitalModel/HospitalModel.dart';
import 'package:child_immunization/Data/Model/KidVaccineModel/KidVaccineModel.dart';
import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Data/Model/LoginModel/LoginModel.dart';
import 'package:child_immunization/Data/Model/NotifyModel/NotifyModel.dart';
import 'package:child_immunization/Data/Model/VaccineModel/VaccineModel.dart';
import 'package:child_immunization/Helper/Constants/Setting.dart';
import 'package:dio/dio.dart';

class Repository {
  final Dio _dio = Dio();

  Future<dynamic> getAdvice() async {
    try {
      Response response = await _dio.get("${Setting.baseUrl}advice");

      var response2 =
          (response.data as List).map((x) => AdviceModel.fromJson(x)).toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> getNotify() async {
    try {
      Response response = await _dio.get("${Setting.baseUrl}notify");

      var response2 =
          (response.data as List).map((x) => NotifyModel.fromJson(x)).toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> getKids({required int id}) async {
    try {
      Response response =
          await _dio.get("${Setting.baseUrl}Kids/by/parent/$id");

      var response2 =
          (response.data as List).map((x) => KidsModel.fromJson(x)).toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> login({
    required String userName,
    required String password,
  }) async {
    try {
      Response response =
          await _dio.post("${Setting.baseUrl}Auth/mobile_login", data: {
        "user_name": userName,
        "Password": password,
      });

      return Future.value(LoginModel.fromJson(response.data));
    } on DioError catch (DioError) {
      if (DioError.message ==
          "The request returned an invalid status code of 404.") {
        return "User not found";
      }

      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> changePassword({
    required int id,
    required String password,
  }) async {
    try {
      Response response = await _dio.put(
          "${Setting.baseUrl}Parent/changepassword/$id?password=$password");

      return Future.value(LoginModel.fromJson(response.data));
    } on DioError catch (DioError) {
      if (DioError.message ==
          "The request returned an invalid status code of 404.") {
        return "User not found";
      }

      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> addToken({
    required int id,
    required String? token,
  }) async {
    try {
      Response response =
          await _dio.put("${Setting.baseUrl}Parent/addtoken/$id?token=$token");

      return Future.value(LoginModel.fromJson(response.data));
    } on DioError catch (DioError) {
      if (DioError.message ==
          "The request returned an invalid status code of 404.") {
        return "User not found";
      }

      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> getNotifications({required int id}) async {
    try {
      Response response =
          await _dio.get("${Setting.baseUrl}Kids/by/vaccine/$id");

      var response2 =
          (response.data as List).map((x) => KidsModel.fromJson(x)).toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> getHospitals() async {
    try {
      Response response = await _dio.get("${Setting.baseUrl}Hospital");

      var response2 = (response.data as List)
          .map((x) => HospitalModel.fromJson(x))
          .toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> getVaccine() async {
    try {
      Response response = await _dio.get("${Setting.baseUrl}vaccine");
      var response2 =
          (response.data as List).map((x) => VaccineModel.fromJson(x)).toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }

  Future<dynamic> getKidVaccine(int id) async {
    try {
      Response response = await _dio.get("${Setting.baseUrl}kid_vaccine/$id");

      var response2 = (response.data as List)
          .map((x) => KidVaccineModel.fromJson(x))
          .toList();

      return Future.value(response2);
    } on DioError catch (DioError) {
      if (DioError.error == "Connection failed") {
        return "Connection failed";
      }
      return DioError.toString();
    }
  }
}
