import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Pages/VaccinePage.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CardChildren extends StatelessWidget {
  final KidsModel kid;
  const CardChildren({super.key, required this.kid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () async {
          await Hive.openBox("Vaccine");
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return VaccinePage(kid: kid);
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.centerRight,
          height: 50,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: MyColors.backgroundColor),
          child: Text(
            kid.name,
            style: const TextStyle(fontSize: 20, color: MyColors.white),
          ),
        ),
      ),
    );
  }
}
