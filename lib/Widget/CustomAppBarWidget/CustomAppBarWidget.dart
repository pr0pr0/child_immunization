import 'package:child_immunization/Helper/Constants/MyColors.dart';
import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatefulWidget {
  final String title;
  final String icon;

  const CustomAppBarWidget(
      {super.key, required this.title, required this.icon});

  @override
  State<CustomAppBarWidget> createState() => _CustomAppBarWidgetState();
}

class _CustomAppBarWidgetState extends State<CustomAppBarWidget> {
  var top = 300.0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                icon: Icon(Icons.menu),
                iconSize: 35.0,
                color: MyColors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
            Row(
              children: [
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: top <= 90 ? 1 : 0,
                  child: Padding(
                    padding: const EdgeInsetsDirectional.only(end: 12),
                    child: Text(
                      widget.title,
                      style: const TextStyle(fontSize: 20, color: MyColors.white),
                    ),
                  ),
                ),
                true
                    ? const CircleAvatar(
                        backgroundColor: MyColors.white,
                        radius: 18,
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: MyColors.blueblack,
                        ),
                      )
                    : CircleAvatar(
                        backgroundColor: MyColors.white,
                        radius: 27,
                        //backgroundImage: FileImage(File(user.imageUrl)),
                        child: Icon(Icons.person, size: 50),
                      ),
              ],
            )
          ],
        ),
      ),
      leadingWidth: MediaQuery.of(context).size.width,
      backgroundColor: MyColors.backgroundColor,
      pinned: true,
      expandedHeight: 300,
      flexibleSpace: LayoutBuilder(
        builder: (ctx, cons) {
          top = cons.biggest.height;

          return FlexibleSpaceBar(
            titlePadding: const EdgeInsets.only(right: 10),
            centerTitle: false,
            background: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: top <= 100 ? 0 : 1,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.white),
                    child: Text(
                      widget.title,
                      style: const TextStyle(fontSize: 20, color: MyColors.red),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: top <= 220 ? 0 : 1,
                  child: Center(
                    child: Image(
                      width: widget.title == 'مراكز التطعيم'
                          ? 80
                          : widget.title == 'اللقاحات'
                              ? 45
                              : 120,
                      fit: BoxFit.fill,
                      image: AssetImage(widget.icon),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
