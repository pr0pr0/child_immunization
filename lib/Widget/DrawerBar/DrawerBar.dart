import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Pages/AdvicePage.dart';
import 'package:child_immunization/Pages/ChangePasswordPage.dart';
import 'package:child_immunization/Pages/ChildrenPage.dart';
import 'package:child_immunization/Pages/HospitalPage.dart';
import 'package:child_immunization/Pages/LoginPage.dart';
import 'package:child_immunization/Pages/NotificationsPage.dart';
import 'package:child_immunization/Pages/NotifyPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../Data/Model/LoginModel/LoginModel.dart';
import '../../Data/shared_preferences/CustomSharedPreferences.dart';

class DrawerBar extends StatefulWidget {
  DrawerBar({super.key});

  @override
  State<DrawerBar> createState() => _DrawerBarState();
}

String? language;

class _DrawerBarState extends State<DrawerBar> {
  late int userId = 0;
  late LoginModel _user =
      LoginModel(id: 0, name: "", image_path: "", password: "");

  @override
  void initState() {
    getUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: MyColors.white,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 30,
            ),
            Row(
              children: [
                Image(
                  width: 80,
                  color: MyColors.backgroundColor,
                  image: AssetImage(
                    'assets/images/Icon.png',
                  ),
                ),
                Text(
                  'تحصين الأطفال',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: MyColors.grey),
                ),
              ],
            ),
            const Divider(
              color: MyColors.lightgrey,
              thickness: 8,
            ),
            userId != 0
                ? ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: MyColors.backgroundColor,
                    ),
                    title: Text(
                      _user.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: MyColors.grey),
                    ),
                  )
                : Container(),
            const Divider(
              color: MyColors.lightgrey,
              thickness: 8,
            ),
            ListTile(
              onTap: userId != 0
                  ? () async {
                      await Hive.openBox("Children");
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c) => const ChildrenPage(),
                        ),
                      );
                    }
                  : () {},
              leading: Image(
                width: 26,
                color: userId != 0
                    ? MyColors.backgroundColor
                    : MyColors.greenLight,
                image: AssetImage(
                  'assets/images/Children.png',
                ),
              ),
              title: Text(
                'قائمة الاطفال',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: userId != 0 ? MyColors.grey : MyColors.greyLight),
              ),
            ),
            ListTile(
              onTap: () async {
                await Hive.openBox("Advice");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (c) => AdvicePage(),
                  ),
                );
              },
              leading: Image(
                width: 26,
                color: MyColors.backgroundColor,
                image: AssetImage(
                  'assets/images/Advice.png',
                ),
              ),
              title: Text(
                'نصائح',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: MyColors.grey),
              ),
            ),
            ListTile(
              onTap: () async {
                await Hive.openBox("Notify");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (c) => const NotifyPage(),
                  ),
                );
              },
              leading: Image(
                width: 26,
                color: MyColors.backgroundColor,
                image: AssetImage(
                  'assets/images/Notify.png',
                ),
              ),
              title: Text(
                'التنبيهات',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: MyColors.grey),
              ),
            ),
            ListTile(
              onTap: userId != 0
                  ? () async {
                      await Hive.openBox("Notifications");
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c) => const NotificationsPage(),
                        ),
                      );
                    }
                  : () {},
              leading: Image(
                width: 24,
                color: userId != 0
                    ? MyColors.backgroundColor
                    : MyColors.greenLight,
                image: AssetImage(
                  'assets/images/Notifications.png',
                ),
              ),
              title: Text(
                'الاشعارات',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: userId != 0 ? MyColors.grey : MyColors.greyLight),
              ),
            ),
            ListTile(
              onTap: () async {
                await Hive.openBox("Hospitals");
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (c) => const HospitalPage(),
                  ),
                );
              },
              leading: const Image(
                width: 20,
                color: MyColors.backgroundColor,
                image: AssetImage(
                  'assets/images/location.png',
                ),
              ),
              title: const Text(
                'تحديد مراكز التطعيم',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: MyColors.grey,
                ),
              ),
            ),
            ListTile(
              onTap: userId != 0
                  ? () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c) => const ChangePasswordPage(),
                        ),
                      );
                    }
                  : () {},
              leading: Image(
                width: 24,
                color: userId != 0
                    ? MyColors.backgroundColor
                    : MyColors.greenLight,
                image: AssetImage(
                  'assets/images/change_password.png',
                ),
              ),
              title: Text(
                'تغيير كلمة المرور',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: userId != 0 ? MyColors.grey : MyColors.greyLight),
              ),
            ),
            const Divider(
              color: MyColors.lightgrey,
              thickness: 8,
            ),
            SizedBox(
              height: userId != 0
                  ? MediaQuery.of(context).size.width / 2.8
                  : (MediaQuery.of(context).size.width + 150) / 2.8,
            ),
            userId != 0
                ? ListTile(
                    onTap: () async {
                      await Hive.openBox("Advice");
                      HiveDB().deleteBox("Children", userId);
                      await FirebaseMessaging.instance.deleteToken();
                      await CustomSharedPreferences.deleteKey("MyUser");
                      userId = 0;
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c) => const AdvicePage(),
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.logout,
                      color: MyColors.backgroundColor,
                      size: 26,
                    ),
                    title: const Text(
                      'تسجيل خروج',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: MyColors.grey),
                    ),
                  )
                : ListTile(
                    onTap: () async {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (c) => const LoginPage(),
                        ),
                      );
                    },
                    leading: const Icon(
                      Icons.login,
                      color: MyColors.backgroundColor,
                      size: 26,
                    ),
                    title: const Text(
                      'تسجيل دخول',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: MyColors.grey),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> getUser() async {
    await CustomSharedPreferences.get('MyUser').then((value) async {
      if (value != null) {
        _user = await HiveDB().getOneBox('MyUser', value);
        userId = value;
      }
    });

    setState(() {});
  }
}


/*
Future<void> openUrl(String url) async {
  final Uri googleUrl = Uri.parse(url);
  if (await canLaunchUrl(googleUrl)) {
    await launchUrl(googleUrl);
  } else {
    throw 'Could not open Url.';
  }
 
}
 */