import 'package:child_immunization/Data/HiveDB/HiveDB.dart';
import 'package:child_immunization/Data/Model/AdviceModel/AdviceModel.dart';
import 'package:child_immunization/Data/Repository/Repository.dart';
import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:child_immunization/Widget/CustomAppBarWidget/CustomAppBarWidget.dart';
import 'package:child_immunization/Widget/DrawerBar/DrawerBar.dart';
import 'package:child_immunization/Widget/NotificationsWidget/CardNotificationsWidget.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

bool right = true;

ScrollController _scrollController = ScrollController();

class _NotificationsPageState extends State<NotificationsPage> {
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
                icon: 'assets/images/Notifications.png',
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
                child: ValueListenableBuilder(
                  valueListenable: Hive.box('Notifications').listenable(),
                  builder: (context, box, widget) {
                    if (box.isNotEmpty) {
                      return ListView.builder(
                        itemCount: box.length,
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return CardNotificationsWidget(
                            message: box.getAt(index).message,
                            name: box.getAt(index).name,
                          );
                        },
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height - 650),
                        child: Text(
                          "لا يوجد بيانات لعرضها حاليا",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: MyColors.backgroundColor,
                              fontWeight: FontWeight.w800,
                              fontSize: 26),
                        ),
                      );
                    }
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
