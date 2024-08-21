import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:bassant_academy/presentation/widgets/shimmer_widgets/shimmer_effect_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/res/res.dart';
import '../../../../app/util/constants.dart';
import '../../../widgets/app_widgets/app_text.dart';

class LessonShimmerCardView extends StatelessWidget {
  static double height = 200;

  const LessonShimmerCardView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {},
      child: SizedBox(
        width: Get.width * 0.44,
        height: height,
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Colors.black,
              width: 0.1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: MyShimmerEffectUI.rectangular(
                  height: height / 1.7,
                  width: double.infinity,
                  radius: 8,
                ),
              ),
              10.ph,
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: MyShimmerEffectUI.rectangular(
                  height: 13,
                  width: 150,
                ),
              ),5.ph, const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: MyShimmerEffectUI.rectangular(
                  height: 13,
                  width: 120,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
