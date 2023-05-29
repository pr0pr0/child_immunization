import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/AdviceModel/AdviceModel.dart';
import 'package:child_immunization/Data/Model/HospitalModel/HospitalModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/AdviceWidget/CardAdviceWidget.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:child_immunization/Widget/HospitalWidget/CardHospital.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

ScrollController _scrollController = ScrollController();

class _HospitalPageState extends State<HospitalPage> {
  dynamic getHospitals;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    getHospitals = getHospitalsDB();
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
                icon: 'assets/images/location.png',
                title: 'مراكز التطعيم',
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
                  future: getHospitals,
                  builder: (context, snapshot) {
                    return ValueListenableBuilder(
                      valueListenable: Hive.box('Hospitals').listenable(),
                      builder: (context, box, widget) {
                        if (box.isNotEmpty) {
                          return ListView.builder(
                            itemCount: box.length,
                            primary: false,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return CardHospital(hospital: box.getAt(index),);
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

Future<dynamic> getHospitalsDB() async {
  List<dynamic> _hospitas = await HiveDB().getBoxes('Hospitals');
  try {
    var res = await Repository().getHospitals();

    if (res.runtimeType != String && res is List<HospitalModel>) {
      res.forEach((element) async {
        await HiveDB().addOneBox(element, "Hospitals");
      });

      _hospitas.forEach((hospital) async {
        var existingItem = res.firstWhere((hospitals) => hospitals.id == hospital.id,
            orElse: () => HospitalModel(
                id: 0,
                name: "",
                typeId: 0,
                latitude: "",
                longtitude: "",
                cityId: 0,
                hospitalType: "",
                city: "",
                address: "",
                phoneNumber: 0));
        if (existingItem.id == 0) {
          await HiveDB().deleteBox("Hospitals", hospital.id);
        }
      });
      if (res != []) {
        return "don";
      } else {
        return "لا يوجد مراكز او مستشفيات بعد";
      }
    } else {
      if (_hospitas.isEmpty) {
        return 'لا يوجد انترنت';
      }
    }
  } catch (_) {
    return 'حصل خطى ما';
  }
}
