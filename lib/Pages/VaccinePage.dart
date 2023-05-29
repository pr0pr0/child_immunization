import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/KidVaccineModel/KidVaccineModel.dart';
import 'package:child_immunization/Data/Model/KidsModel/KidsModel.dart';
import 'package:child_immunization/Data/Model/VaccineModel/VaccineModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:child_immunization/Widget/VaccineWidget/CardVaccineWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class VaccinePage extends StatefulWidget {
  final KidsModel kid;
  const VaccinePage({super.key, required this.kid});

  @override
  State<VaccinePage> createState() => _VaccinePageState();
}

ScrollController _scrollController = ScrollController();

class _VaccinePageState extends State<VaccinePage> {
  dynamic getVaccine;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    getVaccine = getVaccineDB(widget.kid);
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
                icon: 'assets/images/Vaccine.png',
                title: 'اللقاحات',
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
                  future: getVaccine,
                  builder: (context, snapshot) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box('Vaccine').listenable(),
                      builder: (context, box, widget) {
                        if (box.isNotEmpty) {
                          return ListView.builder(
                            itemCount: box.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CardVaccineWidget(
                                vaccine: box.getAt(index),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future<dynamic> getVaccineDB(KidsModel kid) async {
  List<dynamic> _vaccine = await HiveDB().getBoxes('Vaccine');
  try {
    var res = await Repository().getVaccine();
   
    var kidVaccine = await Repository().getKidVaccine(kid.id);
    if (res.runtimeType != String && res is List<VaccineModel>) {
      res.forEach((element) async {
        if (kidVaccine.runtimeType != String &&
            kidVaccine is List<KidVaccineModel>) {
          var existingItem = kidVaccine.firstWhere(
            (value) => value.vaccinesId == element.id,
            orElse: () => KidVaccineModel(kidId: 0, vaccinesId: 0),
          );
          if (existingItem.kidId == 0) {
            await HiveDB().addOneBox(element, "Vaccine");
          } else {
            await HiveDB().addOneBox(
                VaccineModel(
                    id: element.id,
                    name: element.name,
                    daysToTake: element.daysToTake,
                    desc: element.desc,
                    dose: element.dose,
                    isTaken: true),
                "Vaccine");
          }
        }
      });

      _vaccine.forEach((vaccine) async {
        var existingItem = res.firstWhere(
          (value) => value.id == vaccine.id,
          orElse: () => VaccineModel(
              id: 0,
              name: "",
              daysToTake: 0,
              desc: "",
              dose: "",
              isTaken: false),
        );
        if (existingItem.id == 0) {
          await HiveDB().deleteBox("Vaccine", vaccine.id);
        }
      });
      if (res != []) {
        return "don";
      } else {
        return "لا يوجد بيانات بعد";
      }
    } else {
      if (_vaccine.isEmpty) {
        return 'لا يوجد انترنت';
      }
    }
  } catch (mess) {
    print(mess.toString());
    return 'حصل خطى ما';
  }
}
