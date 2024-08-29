import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/util/constants.dart';
import 'package:bassant_academy/data/entities/college_model.dart';
import 'package:bassant_academy/data/entities/level_model.dart';
import 'package:bassant_academy/data/entities/subject_response.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../app/util/operation_reply.dart';
import '../../../data/entities/country_model.dart';
import '../../../data/entities/subject_model.dart';
import '../../../data/entities/university_model.dart';
import '../../../data/providers/network/api_provider.dart';
import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class SubjectsScreen extends StatefulWidget {
  final CountryModel countryModel;
  final UniversityModel universityModel;
  final CollegeModel collegeModel;
  final LevelModel levelModel;

  const SubjectsScreen({
    super.key,
    required this.countryModel,
    required this.universityModel,
    required this.collegeModel,
    required this.levelModel,
  });

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  List<int> selectedSubjectsIds = [];
  List<SubjectModel> subjects = [];

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    setState(() {
      _loading = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSubjects();
  }

  Future<void> _loadSubjects() async {
    loading = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiSubjects}?studyLevelId=${widget.levelModel.id}',
      fromJson: SubjectResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      SubjectResponse subjectResponse = operationReply.result;
      subjects = subjectResponse.data ?? [];
      loading = false;
    } else {
      loading = false;
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${'choose_subject'.tr} ( ${widget.levelModel.name} )"),
        centerTitle: false,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : subjects.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _loadSubjects,
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
                                    color: selectedSubjectsIds.contains(index)
                                        ? Theme.of(context).primaryColor
                                        : Colors.black,
                                    width: selectedSubjectsIds.contains(index)
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
                                          value: selectedSubjectsIds
                                              .contains(index),
                                          side: const BorderSide(
                                            style: BorderStyle.none,
                                          ),
                                          fillColor: selectedSubjectsIds
                                                  .contains(index)
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
                            ),
                            separatorBuilder: (context, index) => 5.ph,
                            itemCount: subjects.length,
                          ),
                        ),
                      ),
                      AppProgressButton(
                        backgroundColor:
                            selectedSubjectsIds.isEmpty ? Colors.grey : null,
                        onPressed: (animationController) async {
                          if (selectedSubjectsIds.isEmpty) {
                            return;
                          } else {
                            sendRequest();
                          }
                        },
                        child: AppText('submit'.tr),
                      )
                    ],
                  ),
                ),
    );
  }

  void sendRequest() async {
    print(selectedSubjectsIds);
    // Get.to(
    //   () => const HomeScreen(),
    //   binding: HomeScreenBinding(),
    // );
  }
}
