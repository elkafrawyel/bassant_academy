import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/screens/university/university_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<String> countries = [
    'مصر',
    'السعودية',
    'الإمارات',
  ];

  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_country'.tr),
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
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1024px-Flag_of_Egypt.svg.png',
                          width: 40,
                          height: 40,
                        ),
                        10.pw,
                        AppText(countries[index]),
                      ],
                    ),
                    selectedColor: Colors.white,
                    tileColor: const Color(0xffF5F5F5),
                  ),
                ),
                separatorBuilder: (context, index) => 10.ph,
                itemCount: countries.length,
              ),
            ),
            AppProgressButton(
              backgroundColor: selectedIndex == -1 ? Colors.grey : null,
              onPressed: (animationController) async {
                if (selectedIndex == -1) {
                  return;
                } else {
                  Get.to(
                    () => const UniversityScreen(),
                  );
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
