import 'package:child_immunization/Data/Model/HospitalModel/HospitalModel.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CardHospital extends StatelessWidget {
  final HospitalModel hospital;
  const CardHospital({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyColors.backgroundColor),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              openMap(hospital.latitude, hospital.longtitude);
            },
            child: Image(
              width: 40,
              fit: BoxFit.cover,
              image: AssetImage('assets/images/map.png'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  hospital.name,
                  style: TextStyle(fontSize: 18, color: MyColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  hospital.city,
                  style: TextStyle(fontSize: 18, color: MyColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  hospital.address,
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

Future<void> openMap(String latitude, String longitude) async {
  final Uri googleUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
  if (await canLaunchUrl(googleUrl)) {
    await launchUrl(googleUrl);
  } else {
    throw 'Could not open the map.';
  }
}
