import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Data/shared_preferences/CustomSharedPreferences.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/ChildrenWidget/CardChildren.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChildrenPage extends StatefulWidget {
  const ChildrenPage({super.key});

  @override
  State<ChildrenPage> createState() => _ChildrenPageState();
}

ScrollController _scrollController = ScrollController();

class _ChildrenPageState extends State<ChildrenPage> {
  dynamic getKids;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    getKids = getChildren();
    super.initState();
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
                icon: 'assets/images/Children.png',
                title: 'الاطفال',
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
                child: FutureBuilder(
                  future: getKids,
                  builder: (context, snapshot) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box('Children').listenable(),
                      builder: (context, box, widget) {
                        if (box.isNotEmpty) {
                          return ListView.builder(
                            itemCount: box.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CardChildren(
                                kid: box.getAt(index),
                              );
                            },
                          );
                        } else {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height - 650),
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: MyColors.backgroundColor,
                                ),
                              ),
                            );
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height - 650),
                              child: Text(
                                snapshot.data.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: MyColors.backgroundColor,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 26),
                              ),
                            );
                          }
                          return Container();
                        }
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getChildren() async {
  List<dynamic> _advice = await HiveDB().getBoxes('Children');
  int id = await CustomSharedPreferences.get('MyUser');
  try {
    var res = await Repository().getKids(id: id);

    if (res.runtimeType != String && res is List<KidsModel>) {
      res.forEach((element) async {
        await HiveDB().addOneBox(element, "Children");
      });

      _advice.forEach((advice) async {
        var existingItem = res.firstWhere((value) => value.id == advice.id,
            orElse: () => KidsModel(
                  id: 0,
                  name: "",
                  pirth_date: "",
                  pirth_place: "",
                  blood: "",
                ));
        if (existingItem.id == 0) {
          await HiveDB().deleteBox("Children", advice.id);
        }
      });
      if (res != []) {
        return "don";
      } else {
        return "لا يوجد اطفال لديك";
      }
    } else {
      if (_advice.isEmpty) {
        return 'لا يوجد انترنت';
      }
    }
  } catch (_) {
    return 'حصل خطى ما';
  }
}
