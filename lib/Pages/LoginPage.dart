import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/LoginModel/LoginModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Data/shared_preferences/CustomSharedPreferences.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Pages/AdvicePage.dart';
import 'package:child_immunization/Pages/ChildrenPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _userName = TextEditingController();

  TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _userName.clear();
    _password.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: MyColors.backgroundColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: MyColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Image(
                  image: AssetImage('assets/images/Login.png'),
                ),
              ),
              Container(
                alignment: Alignment.center,
                height: 45,
                width: 280,
                decoration: BoxDecoration(
                    color: MyColors.backgroundColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: MyColors.grey,
                          blurRadius: 1,
                          offset: Offset(0, 1)),
                      BoxShadow(
                          color: MyColors.grey,
                          blurRadius: 1,
                          offset: Offset(0, 1)),
                      BoxShadow(
                          color: MyColors.grey,
                          blurRadius: 1,
                          offset: Offset(0, 1))
                    ]),
                child: Text(
                  'تسجيل الدخول',
                  style: TextStyle(fontSize: 20, color: MyColors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 40, bottom: 8),
                        child: Text(
                          "أسم المستخدم",
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.grey)),
                        child: TextField(
                          controller: _userName,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 40, bottom: 8),
                        child: Text(
                          "كلمة المرور",
                          style: TextStyle(
                              fontSize: 16,
                              color: MyColors.white,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: MyColors.grey)),
                        child: TextField(
                          controller: _password,
                          style: TextStyle(fontSize: 20),
                          decoration: InputDecoration(border: InputBorder.none),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 60),
                  InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () async {
                      final String? token =
                          await FirebaseMessaging.instance.getToken();
                      if (_userName.text.isNotEmpty &&
                          _password.text.isNotEmpty) {
                        buildShowDialog(context);
                        await Hive.openBox("Children");
                        Repository()
                            .login(
                                password: _password.text,
                                userName: _userName.text)
                            .then((value) async {
                          if (value.runtimeType != String &&
                              value is LoginModel) {
                            Repository().addToken(id: value.id, token: token);
                            await HiveDB().addOneBox(value, "MyUser");
                            await CustomSharedPreferences.setInt(
                                    'MyUser', value.id)
                                .whenComplete(() async {
                              Navigator.of(context).pop();
                              await Hive.openBox("Children");
                              Fluttertoast.showToast(
                                  msg: "تم تسجيل الدخول",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: MyColors.grey,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (c) => const ChildrenPage(),
                                ),
                              );
                            });
                          } else {
                            Navigator.of(context).pop();
                            if (value == "User not found") {
                              Fluttertoast.showToast(
                                  msg: "تاكد من البيانات",
                                  toastLength: Toast.LENGTH_LONG,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: MyColors.grey,
                                  textColor: Colors.white,
                                  fontSize: 18.0);
                            }
                            Fluttertoast.showToast(
                                msg: "لا يوجد انترنت",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: MyColors.grey,
                                textColor: Colors.white,
                                fontSize: 18.0);
                          }
                        });
                      } else {
                        Fluttertoast.showToast(
                            msg: "يجب مل جميع الحقول ",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: MyColors.grey,
                            textColor: Colors.white,
                            fontSize: 18.0);
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.red),
                      child: Text(
                        'دخــــــول',
                        style: TextStyle(fontSize: 20, color: MyColors.white),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                        color: MyColors.white,
                        borderRadius: BorderRadius.circular(12)),
                    child: InkWell(
                      onTap: () async {
                        await Hive.openBox("Advice");
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (c) => const AdvicePage(),
                          ),
                        );
                      },
                      child: Text(
                        'دخول كزائر',
                        style: TextStyle(fontSize: 12, color: MyColors.red),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

buildShowDialog(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(
            color: MyColors.backgroundColor,
          ),
        );
      });
}
