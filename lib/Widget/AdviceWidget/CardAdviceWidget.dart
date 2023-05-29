// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';

class CardAdviceWidget extends StatelessWidget {
  final int index;
  final String advice;
  const CardAdviceWidget({
    Key? key,
    required this.index,
    required this.advice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return index.floor().isEven
        ? IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                progressIndicator(right: true, context: context),
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  alignment: Alignment.topRight,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2.4,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 12),
                    decoration: BoxDecoration(
                      color: MyColors.lightgrey,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.backgroundColor,
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      advice,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                ),

                // Expanded(...)
              ],
            ),
          )
        : IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width / 2.4,
                  alignment: Alignment.topLeft,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width / 2.4,
                    ),
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    margin: EdgeInsets.symmetric(vertical: 20,horizontal: 12),
                    decoration: BoxDecoration(
                      color: MyColors.lightgrey,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Text(
                      advice,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: MyColors.grey,
                      ),
                    ),
                  ),
                ),
                progressIndicator(right: false, context: context),
              ],
            ),
          );
  }
}

Widget progressIndicator({required bool right, required BuildContext context}) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: AlignmentDirectional.center,
    children: [
      Container(
        margin: right
            ? EdgeInsets.only(
                right: (MediaQuery.of(context).size.width / 2) -
                    ((MediaQuery.of(context).size.width + 37.4) / 2.4))
            : EdgeInsets.only(
                left: (MediaQuery.of(context).size.width / 2) -
                    ((MediaQuery.of(context).size.width + 37.4) / 2.4)),
        width: 16.0,
        color: MyColors.backgroundColor,
      ),
      right
          ? Positioned(
              right: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.width * 0.15),
              child: const Icon(
                Icons.circle,
                size: 40,
                color: MyColors.red,
              ),
            )
          : Positioned(
              left: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.width * 0.15),
              child: const Icon(
                Icons.circle,
                size: 40,
                color: MyColors.red,
              ),
            ),
    ],
  );
}
