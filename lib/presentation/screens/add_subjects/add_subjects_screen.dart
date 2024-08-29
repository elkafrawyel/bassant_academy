import 'package:bassant_academy/app/config/app_color.dart';
import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_drop_menu.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/home_screen/home_screen_controller.dart';
import '../../widgets/app_widgets/app_cached_image.dart';

class AddSubjectsScreen extends StatefulWidget {
  const AddSubjectsScreen({super.key});

  @override
  State<AddSubjectsScreen> createState() => _AddSubjectsScreenState();
}

class _AddSubjectsScreenState extends State<AddSubjectsScreen> {
  List<int> selectedSubjectsIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'add_subjects'.tr,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GetBuilder<HomeScreenController>(
          builder: (homeScreenController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppCachedImage(
                      imageUrl: homeScreenController.countryImage,
                      width: 30,
                      height: 25,
                      radius: 8,
                    ),
                    10.pw,
                    AppText(
                      '${homeScreenController.countryName} , ${homeScreenController.universityName}',
                      fontSize: 16,
                    )
                  ],
                ),
                10.ph,
                AppText(
                  homeScreenController.collegeName,
                  fontSize: 16,
                  color: Constants.kClickableTextColor,
                ),
                const Divider(
                  color: hintColor,
                  indent: 18,
                  endIndent: 18,
                  thickness: 0.5,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText(
                    'choose_level'.tr,
                    color: hintColor,
                  ),
                ),
                10.ph,
                AppDropMenu<String>(
                  hint: 'choose_level'.tr,
                  items: const ['A', 'B', 'C', 'D'],
                  onChanged: (String? item) {},
                  expanded: true,
                  bordered: true,
                ),
                10.ph,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: AppText(
                    'choose_subject'.tr,
                    color: hintColor,
                  ),
                ),
                10.ph,
                Expanded(
                  child: ListView.builder(
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
                            color: selectedSubjectsIds.contains(index)
                                ? Theme.of(context).primaryColor
                                : Colors.black,
                            width:
                                selectedSubjectsIds.contains(index) ? 2 : 0.1,
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
                                      : MaterialStateProperty.all(
                                          Colors.grey.shade100),
                                  visualDensity: const VisualDensity(
                                      horizontal: -4.0, vertical: -4.0),
                                  onChanged: (bool? value) {},
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Center(
                    child: AppProgressButton(
                      onPressed: (animationController) async {},
                      text: 'ok'.tr,
                      width: MediaQuery.sizeOf(context).width / 2,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
