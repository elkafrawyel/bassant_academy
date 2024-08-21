import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/presentation/screens/home/components/lesson_shimmer_card_view.dart';
import 'package:bassant_academy/presentation/widgets/shimmer_widgets/shimmer_effect_ui.dart';
import 'package:flutter/material.dart';

import '../../../widgets/app_widgets/app_text.dart';
import 'lesson_card_view.dart';

class AppShimmerHorizontalListView extends StatelessWidget {

  const AppShimmerHorizontalListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: MyShimmerEffectUI.rectangular(height: 15,width: 200,),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  height: LessonShimmerCardView.height + 10,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => 3.pw,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      child: LessonShimmerCardView(
                      ),
                    ),
                    itemCount: 5,
                  ),
                ),
              ),
            ],
          );
  }
}
