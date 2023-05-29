import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/LoginModel/LoginModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Data/shared_preferences/CustomSharedPreferences.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

ScrollController _scrollController = ScrollController();

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  @override
  void initState() {
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    oldPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          drawer: DrawerBar(),
          backgroundColor: MyColors.white,
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              CustomAppBarWidget(
                icon: 'assets/images/change_password.png',
                title: 'تغيير كلمه المرور',
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: MyColors.backgroundColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                        color: MyColors.white),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 40, bottom: 8),
                            child: Text(
                              "كلمة المرور القديمة",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.grey,
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
                              controller: oldPassword,
                              style: TextStyle(fontSize: 20),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
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
                              "كلمة المرور الجديدة",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.grey,
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
                              controller: newPassword,
                              style: TextStyle(fontSize: 20),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
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
                              "تاكيد كلمة االمرور",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: MyColors.grey,
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
                              controller: confirmPassword,
                              style: TextStyle(fontSize: 20),
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () async {
                          await CustomSharedPreferences.get('MyUser')
                              .then((id) async {
                            await HiveDB().getOneBox('MyUser', id).then((user) {
                              if (oldPassword.text.isNotEmpty &&
                                  newPassword.text.isNotEmpty &&
                                  confirmPassword.text.isNotEmpty) {
                                if (oldPassword.text == user.password &&
                                    newPassword.text == confirmPassword.text) {
                                  Repository()
                                      .changePassword(
                                          id: id, password: newPassword.text)
                                      .then((value) async {
                                    if (value.runtimeType != String) {
                                      if (value is LoginModel) {
                                        await HiveDB()
                                            .addOneBox(value, "MyUser");
                                        Fluttertoast.showToast(
                                            msg: "تم تغيير كلمة المرور بنجاح ",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: MyColors.grey,
                                            textColor: Colors.white,
                                            fontSize: 18.0);
                                      } else {
                                        Fluttertoast.showToast(
                                            msg: "حصل خطى ما",
                                            toastLength: Toast.LENGTH_LONG,
                                            gravity: ToastGravity.CENTER,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: MyColors.grey,
                                            textColor: Colors.white,
                                            fontSize: 18.0);
                                      }
                                    } else {
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
                                      msg: "ادخال غير صحيح",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: MyColors.grey,
                                      textColor: Colors.white,
                                      fontSize: 18.0);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "يجب مل جميع الحقول",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: MyColors.grey,
                                    textColor: Colors.white,
                                    fontSize: 18.0);
                              }
                            });
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: MyColors.red),
                          child: Text(
                            'دخــــــول',
                            style:
                                TextStyle(fontSize: 20, color: MyColors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
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
