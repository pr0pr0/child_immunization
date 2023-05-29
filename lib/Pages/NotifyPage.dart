import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/NotifyModel/NotifyModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/NotifyWidget/CardNotifyWidget.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotifyPage extends StatefulWidget {
  const NotifyPage({super.key});

  @override
  State<NotifyPage> createState() => _NotifyPageState();
}

bool right = true;

ScrollController _scrollController = ScrollController();

class _NotifyPageState extends State<NotifyPage> {
  dynamic getNotify;
  @override
  void initState() {
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    getNotify = getNotifyDB();
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
            slivers: [//Notify
            //Notifications
              CustomAppBarWidget(
                icon: 'assets/images/Notify.png',
                title: 'التنبيهات',
              ),
              SliverToBoxAdapter(
                child: Container(
                  color: MyColors.backgroundColor,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 25,
                    decoration: const BoxDecoration(
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
                  future: getNotify,
                  builder: (context, snapshot) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box('Notify').listenable(),
                      builder: (context, box, widget) {
                        if (box.isNotEmpty) {
                          return ListView.builder(
                            itemCount: box.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CardNotifyWidget(notify:box.getAt(index).notify, desc: box.getAt(index).desc);
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getNotifyDB() async {
  List<dynamic> _advice = await HiveDB().getBoxes('Notify');
  try {
    var res = await Repository().getNotify();

    if (res.runtimeType != String && res is List<NotifyModel>) {
      res.forEach((element) async {
        await HiveDB().addOneBox(element, "Notify");
      });

      _advice.forEach((advice) async {
        var existingItem = res.firstWhere((value) => value.id == advice.id,
            orElse: () => NotifyModel(id: 0, notify: "", desc: ""));
        if (existingItem.id == 0) {
          await HiveDB().deleteBox("Notify", advice.id);
        }
      });
      if (res != []) {
        return "don";
      } else {
        return "لا يوجد نصايح بعد";
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
