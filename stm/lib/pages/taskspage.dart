import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stm/controlers/appcontroller.dart';
import 'package:stm/pages/taskpage.dart';

import 'utils/drawer.dart';
import 'utils/utils.dart';

class TasksPage extends GetView<AppController> {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Builder(builder: (context) {
        return SizedBox(
          height: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: null,
                onPressed: () => Get.to(() => TaskPage()),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 28,
                ),
                backgroundColor: Colors.green,
              ),
              FloatingActionButton(
                heroTag: null,
                onPressed: () => Scaffold.of(context).openDrawer(),
                child: const Icon(
                  Icons.apps,
                  color: Colors.white,
                  size: 28,
                ),
                backgroundColor: Colors.red,
              ),
            ],
          ),
        );
      }),
      body: bgWidget(
        bgImage: "assets/images/bg.jpg",
        overlayColor: Colors.black54,
        child: Column(
          children: [
            ClipPath(
              clipper: WaveClip(),
              child: Container(
                padding: EdgeInsets.only(left: 20, top: 20),
                color: Colors.redAccent,
                width: double.infinity,
                height: 160,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    SizedBox(
                      width: Get.size.width / 2,
                      child: Text(
                        'Your tasks',
                        style: GoogleFonts.oswald(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SvgPicture.asset('assets/images/tasks_list.svg'),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  var item = data[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              item.x[0],
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.x,
                              style: GoogleFonts.oswald(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Total: ' +
                                  item.y.toString() +
                                  ' min. | Phases: 2',
                              style: GoogleFonts.openSans(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WaveClip extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    final lowPoint = size.height - 20;
    final highPoint = size.height - 40;
    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(size.width / 4, highPoint, size.width / 2, lowPoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowPoint);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
