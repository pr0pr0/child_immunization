import 'package:child_immunization/Data/Model/AdviceModel/AdviceModel.dart';
import 'package:child_immunization/Data/Model/HospitalModel/HospitalModel.dart';
import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Data/Model/LoginModel/LoginModel.dart';
import 'package:child_immunization/Data/Model/NotificationsModel/NotificationsModel.dart';
import 'package:child_immunization/Data/Model/NotifyModel/NotifyModel.dart';
import 'package:child_immunization/Data/Model/VaccineModel/VaccineModel.dart';
import 'package:hive_flutter/hive_flutter.dart';


class AdapterHelper {
  void adapter() {
    Hive.registerAdapter(AdviceModelAdapter());
    Hive.registerAdapter(KidsModelAdapter());
    Hive.registerAdapter(LoginModelAdapter());
    Hive.registerAdapter(NotifyModelAdapter());
    Hive.registerAdapter(NotificationsModelAdapter());
    Hive.registerAdapter(HospitalModelAdapter());
    Hive.registerAdapter(VaccineModelAdapter());
    



  }
}
