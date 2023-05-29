class KidVaccineModel {
  int kidId;
  int vaccinesId;

  KidVaccineModel({
    required this.kidId,
    required this.vaccinesId,
  });

  factory KidVaccineModel.fromJson(Map<String, dynamic> json) => KidVaccineModel(
        kidId: json["kids_Id"],
        vaccinesId: json["vaccines_Id"] ?? 0,
      );
}
