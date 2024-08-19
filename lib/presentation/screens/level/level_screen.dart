import 'package:bassant_academy/app/extensions/space.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class LevelScreen extends StatefulWidget {
  const LevelScreen({super.key});

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int selectedIndex = -1;

  List<String> levels = ['الفرقة الأولى', 'الفرقة الثانية', 'الفرقة الثالثة'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_level'.tr),
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
                      levels[index],
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    selectedColor: Colors.white,
                    tileColor: const Color(0xffF5F5F5),
                  ),
                ),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: levels.length,
              ),
            ),
            AppProgressButton(
              backgroundColor: selectedIndex == -1 ? Colors.grey : null,
              onPressed: (animationController) async {
                if (selectedIndex == -1) {
                  return;
                } else {
                  // Get.to(() => const CollegeScreen());
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
