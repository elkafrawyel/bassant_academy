import 'package:bassant_academy/data/providers/storage/local_provider.dart';
import 'package:bassant_academy/presentation/controller/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/util/constants.dart';
import '../../../../app/util/language/language_data.dart';
import '../app_text.dart';

class AppLanguageRow extends StatefulWidget {
  const AppLanguageRow({super.key});

  @override
  State<AppLanguageRow> createState() => _AppLanguageRowState();
}

class _AppLanguageRowState extends State<AppLanguageRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: LanguageData.languageList()
          .map(
            (lang) => Expanded(
              child: GestureDetector(
                onTap: () async {
                  await LanguageData.changeLanguage(lang);
                  setState(() {});
                  Get.find<HomeScreenController>().init();
                },
                child: Container(
                  margin: const EdgeInsetsDirectional.only(end: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: LocalProvider().getAppLanguage() != lang.languageCode
                        ? Constants.kClickableTextColor.withOpacity(0.5)
                        : Constants.kClickableTextColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Center(
                      child: AppText(
                        lang.name,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
