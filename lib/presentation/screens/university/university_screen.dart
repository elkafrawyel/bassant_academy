import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/screens/college/college_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class UniversityScreen extends StatefulWidget {
  const UniversityScreen({super.key});

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  int selectedIndex = -1;

  List<String> universities = ['جامعة القاهرة', 'جامعة عين شمس', 'جامعة الإسكندرية'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_university'.tr),
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
                    title: Row(
                      children: [
                        Image.network(
                          'https://ipsf.net/wp-content/uploads/2021/12/dummy-image-square.webp',
                          width: 40,
                          height: 40,
                        ),
                        10.pw,
                        AppText(universities[index]),
                      ],
                    ),
                    selectedColor: Colors.white,
                    tileColor: const Color(0xffF5F5F5),
                  ),
                ),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: universities.length,
              ),
            ),
            AppProgressButton(
              backgroundColor: selectedIndex == -1 ? Colors.grey : null,
              onPressed: (animationController) async {
                if (selectedIndex == -1) {
                  return;
                } else {
                  Get.to(() => const CollegeScreen());
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
