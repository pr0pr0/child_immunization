import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/AdviceModel/AdviceModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/AdviceWidget/CardAdviceWidget.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdvicePage extends StatefulWidget {
  const AdvicePage({super.key});

  @override
  State<AdvicePage> createState() => _AdvicePageState();
}

ScrollController _scrollController = ScrollController();

class _AdvicePageState extends State<AdvicePage> {
  dynamic getAdvice;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    getAdvice = getAdviceDB();
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
                icon: 'assets/images/Advice.png',
                title: 'النصيحة',
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
                  future: getAdvice,
                  builder: (context, snapshot) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box('Advice').listenable(),
                      builder: (context, box, widget) {
                        if (box.isNotEmpty) {
                          return ListView.builder(
                            itemCount: box.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CardAdviceWidget(
                                index: index,
                                advice: box.getAt(index).advice,
                              );
                            },
                          );
                        } else {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height -
                                          650),
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
                                      MediaQuery.of(context).size.height -
                                          650),
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

Future<dynamic> getAdviceDB() async {
  List<dynamic> _advice = await HiveDB().getBoxes('Advice');
  try {
    var res = await Repository().getAdvice();

    if (res.runtimeType != String && res is List<AdviceModel>) {
      res.forEach((element) async {
        await HiveDB().addOneBox(element, "Advice");
      });

      _advice.forEach((advice) async {
        var existingItem = res.firstWhere((value) => value.id == advice.id,
            orElse: () => AdviceModel(id: 0, advice: "advice", desc: "desc"));
        if (existingItem.id == 0) {
          await HiveDB().deleteBox("Advice", advice.id);
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
