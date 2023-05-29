// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:child_immunization/Helper/Constants/MyColors.dart';

class CardNotifyWidget extends StatelessWidget {
  final String notify;
  final String desc;

  const CardNotifyWidget({
    Key? key,
    required this.notify,
    required this.desc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 1.5,
            padding: EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: MyColors.backgroundColor, width: 4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  notify,
                  style: TextStyle(color: MyColors.red, fontSize: 22),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  desc,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          
          Container(
            padding: EdgeInsets.all(8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: MyColors.backgroundColor, width: 4),
            ),
            child: Image.asset(
              'assets/images/Notify.png',
              width: 40,
              color: MyColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
