import 'package:bassant_academy/app/config/app_color.dart';
import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/level_model.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_drop_menu.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../data/entities/general_response.dart';
import '../../../data/entities/level_response.dart';
import '../../../data/entities/subject_model.dart';
import '../../../data/entities/subject_response.dart';
import '../../controller/home_screen/home_screen_controller.dart';
import '../../widgets/app_widgets/app_cached_image.dart';

class AddSubjectsScreen extends StatefulWidget {
  const AddSubjectsScreen({super.key});

  @override
  State<AddSubjectsScreen> createState() => _AddSubjectsScreenState();
}

class _AddSubjectsScreenState extends State<AddSubjectsScreen> {
  final HomeScreenController homeScreenController = Get.find();
  List<LevelModel> levels = [];
  bool _loadingLevels = false;

  bool get loadingLevels => _loadingLevels;

  set loadingLevels(bool value) {
    setState(() {
      _loadingLevels = value;
    });
  }

  void loadLevelsByCollegeId() async {
    loadingLevels = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint:
          '${Res.apiLevels}?collegeId=${homeScreenController.profileResponse?.data?.collage?.id}',
      fromJson: LevelResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      LevelResponse levelResponse = operationReply.result;
      levels = levelResponse.data ?? [];
      loadingLevels = false;

      if (homeScreenController.profileResponse?.data?.level != null) {
        _loadSubjectsByLevel(
            homeScreenController.profileResponse!.data!.level!);
      }
    } else {
      loadingLevels = false;
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  List<SubjectModel> subjects = [];
  List<int> selectedSubjectsIds = [];
  bool _loadingSubjects = false;

  bool get loadingSubjects => _loadingSubjects;

  set loadingSubjects(bool value) {
    setState(() {
      _loadingSubjects = value;
    });
  }

  void _loadSubjectsByLevel(LevelModel level) async {
    loadingSubjects = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiSubjects}?studyLevelId=${level.id}',
      fromJson: SubjectResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      SubjectResponse subjectResponse = operationReply.result;
      subjects = subjectResponse.data ?? [];
      loadingSubjects = false;
    } else {
      loadingSubjects = false;
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  @override
  void initState() {
    super.initState();
    loadLevelsByCollegeId();
  }

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
                      imageUrl: homeScreenController
                          .profileResponse?.data?.country?.image,
                      width: 30,
                      height: 25,
                      radius: 8,
                    ),
                    10.pw,
                    AppText(
                      '${homeScreenController.profileResponse?.data?.country?.name} , ${homeScreenController.profileResponse?.data?.university?.name}',
                      fontSize: 16,
                    )
                  ],
                ),
                10.ph,
                AppText(
                  homeScreenController.profileResponse?.data?.collage?.name ??
                      '',
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
                loadingLevels
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : AppDropMenu<LevelModel>(
                        hint: 'choose_level'.tr,
                        initialValue:
                            homeScreenController.profileResponse?.data?.level,
                        items: levels,
                        onChanged: (LevelModel? level) {
                          if (level != null) {
                            _loadSubjectsByLevel(level);
                          }
                        },
                        expanded: true,
                        bordered: true,
                      ),
                10.ph,
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppText(
                      'choose_subject'.tr,
                      color: hintColor,
                    ),
                  ),
                ),
                10.ph,
                Expanded(
                  child: subjects.isEmpty
                      ? Center(
                          child: SvgPicture.asset(Res.iconStudying),
                        )
                      : ListView.builder(
                          itemBuilder: (context, index) {
                            int id = subjects[index].id!.toInt();
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (selectedSubjectsIds.contains(id)) {
                                    selectedSubjectsIds.remove(id);
                                  } else {
                                    selectedSubjectsIds.add(id);
                                  }
                                });
                              },
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: selectedSubjectsIds.contains(id)
                                        ? Theme.of(context).primaryColor
                                        : Colors.black,
                                    width: selectedSubjectsIds.contains(id)
                                        ? 2
                                        : 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(kRadius),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      AppCachedImage(
                                        imageUrl: subjects[index].image,
                                        width: 90,
                                        height: 90,
                                        radius: 8,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: AppText(
                                            subjects[index].name ?? '',
                                            maxLines: 3,
                                          ),
                                        ),
                                      ),
                                      Transform.scale(
                                        scale: 1.5,
                                        child: Checkbox(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          value:
                                              selectedSubjectsIds.contains(id),
                                          side: const BorderSide(
                                            style: BorderStyle.none,
                                          ),
                                          fillColor: selectedSubjectsIds
                                                  .contains(id)
                                              ? null
                                              : WidgetStatePropertyAll<Color>(
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
                            );
                          },
                          itemCount: subjects.length,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Center(
                    child: AppProgressButton(
                      backgroundColor:
                          selectedSubjectsIds.isEmpty ? Colors.grey : null,
                      onPressed: (animationController) async {
                        if (selectedSubjectsIds.isEmpty) {
                          return;
                        } else {
                          sendRequest(animationController);
                        }
                      },
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

  void sendRequest(AnimationController animationController) async {
    animationController.forward();

    OperationReply operationReply = await APIProvider.instance.post(
      endPoint: Res.apiAddStudentProfile,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'SubjectIds': selectedSubjectsIds,
      },
    );

    if (operationReply.isSuccess()) {
      animationController.reverse();
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.data ?? '');
      Get.back();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
