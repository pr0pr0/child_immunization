import 'package:child_immunization/Data/shared_preferences/CustomSharedPreferences.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Pages/ChildrenPage.dart';
import 'package:child_immunization/Pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image(
                  width: 150,
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/Logo.png'),
                ),
              ),
              SizedBox(
                height: 120,
              ),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(44),
                          topRight: Radius.circular(44),
                        ),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 90,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 60),
                            child: Text(
                              textAlign: TextAlign.center,
                              "تحصين الاطفال هو تطبيق يحرص على تنــظــيـــم جـــرعـــات \الـــتـلقـيح لـطـفـلك وتـــــذكــيـــرك بــــمــــوعــــد الــــجــرعــــــات واعطاء نصائح مهمه للحفاظ على صحة طفلك",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Color.fromRGBO(101, 100, 100, 1),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              await CustomSharedPreferences.get('MyUser')
                                  .then((userId) async {
                                if (userId != null) {
                                  await Hive.openBox("Children");
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (c) => const ChildrenPage(),
                                    ),
                                  );
                                } else {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (c) => const LoginPage(),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: MyColors.red),
                              child: Text(
                                'اســـتـــمــــرار',
                                style: TextStyle(
                                    fontSize: 20, color: MyColors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: -90,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Image(
                          width: 180,
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/baby.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
