import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/controller/home_screen_controller/home_screen_binding.dart';
import 'package:bassant_academy/presentation/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<int> selectedSubjectsIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('choose_subject'.tr),
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
                      if (selectedSubjectsIds.contains(index)) {
                        selectedSubjectsIds.remove(index);
                      } else {
                        selectedSubjectsIds.add(index);
                      }
                    });
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: selectedSubjectsIds.contains(index) ? Theme.of(context).primaryColor : Colors.black,
                        width: selectedSubjectsIds.contains(index) ? 2 : 0.1,
                      ),
                      borderRadius: BorderRadius.circular(kRadius),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            'https://media.istockphoto.com/id/1216658448/photo/stack-of-colorful-books-isolated-on-white-background-collection-of-different-books-hardback.jpg?s=612x612&w=0&k=20&c=_8yq2H5pkScnt0-DXkud4EEJKi8P0RRzZpAUSrh5lvk=',
                            width: 90,
                            height: 90,
                          ),
                          const Expanded(
                            child: AppText(
                              'التشريح الآدمى وعلم الاجنة',
                              maxLines: 3,
                            ),
                          ),
                          Transform.scale(
                            scale: 1.5,
                            child: Checkbox(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                              value: selectedSubjectsIds.contains(index),
                              side: const BorderSide(
                                style: BorderStyle.none,
                              ),
                              fillColor: selectedSubjectsIds.contains(index)
                                  ? null
                                  : WidgetStatePropertyAll<Color>(Colors.grey.shade100),
                              visualDensity: const VisualDensity(horizontal: -4.0, vertical: -4.0),
                              onChanged: (bool? value) {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => 5.ph,
                itemCount: 10,
              ),
            ),
            AppProgressButton(
              backgroundColor: selectedSubjectsIds.isEmpty ? Colors.grey : null,
              onPressed: (animationController) async {
                if (selectedSubjectsIds.isEmpty) {
                  return;
                } else {
                  Get.to(() => const HomeScreen(), binding: HomeScreenBinding());
                }
              },
              child: AppText('submit'.tr),
            )
          ],
        ),
      ),
    );
  }
}
