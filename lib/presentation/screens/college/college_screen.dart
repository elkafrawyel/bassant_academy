import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/screens/level/level_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class CollegeScreen extends StatefulWidget {
  const CollegeScreen({super.key});

  @override
  State<CollegeScreen> createState() => _CollegeScreenState();
}

class _CollegeScreenState extends State<CollegeScreen> {
  int selectedIndex = -1;

  List<String> colleges = ['حاسبات وعلوم الكمبيوتر', 'الطب البشري', 'الطب البيطري'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_college'.tr),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                    ),
                    selected: selectedIndex == index,
                    selectedTileColor: Theme.of(context).primaryColor,
                    title: AppText(
                      colleges[index],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedColor: Colors.white,
                    tileColor: const Color(0xffF5F5F5),
                  ),
                ),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: colleges.length,
              ),
            ),
            AppProgressButton(
              backgroundColor: selectedIndex == -1 ? Colors.grey : null,
              onPressed: (animationController) async {
                if (selectedIndex == -1) {
                  return;
                } else {
                  Get.to(() => const LevelScreen());
                }
              },
              child: AppText('continue'.tr),
            )
          ],
        ),
      ),
    );
  }
}
