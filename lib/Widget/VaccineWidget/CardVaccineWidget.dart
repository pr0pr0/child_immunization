import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Data/Model/VaccineModel/VaccineModel.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:flutter/material.dart';

class CardVaccineWidget extends StatelessWidget {
  final VaccineModel vaccine;
  const CardVaccineWidget({super.key, required this.vaccine});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColors.backgroundColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 125,
            child: Text(
              vaccine.isTaken ? "تم اخذ الجرعة" : "لم يتم اخذ الجرعه بعد",
              style: TextStyle(
                  fontSize: 14,
                  color: vaccine.isTaken
                      ? MyColors.backgroundColor
                      : MyColors.grey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textDirection: TextDirection.rtl,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width-175,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  vaccine.dose,
                  style: TextStyle(fontSize: 18, color: MyColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  vaccine.name,
                  style: TextStyle(fontSize: 18, color: MyColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'يتم اخذ الجرعه في اليوم ${vaccine.daysToTake}',
                  style: TextStyle(fontSize: 18, color: MyColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
