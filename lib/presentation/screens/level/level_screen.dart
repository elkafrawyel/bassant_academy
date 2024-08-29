import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/entities/college_model.dart';
import 'package:bassant_academy/data/entities/country_model.dart';
import 'package:bassant_academy/data/entities/level_model.dart';
import 'package:bassant_academy/data/entities/level_response.dart';
import 'package:bassant_academy/data/entities/university_model.dart';
import 'package:bassant_academy/presentation/screens/subjects/subjects_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../app/util/operation_reply.dart';
import '../../../data/providers/network/api_provider.dart';
import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class LevelScreen extends StatefulWidget {
  final CountryModel countryModel;
  final UniversityModel universityModel;
  final CollegeModel collegeModel;

  const LevelScreen({
    super.key,
    required this.countryModel,
    required this.universityModel,
    required this.collegeModel,
  });

  @override
  State<LevelScreen> createState() => _LevelScreenState();
}

class _LevelScreenState extends State<LevelScreen> {
  int selectedIndex = -1;

  List<LevelModel> levels = [];

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
    _loadLevels();
  }

  Future<void> _loadLevels() async {
    loading = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiLevels}?collegeId=${widget.collegeModel.id}',
      fromJson: LevelResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      LevelResponse levelResponse = operationReply.result;
      levels = levelResponse.data ?? [];
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
        title: Text("${'choose_level'.tr} ( ${widget.collegeModel.name} )"),
        centerTitle: false,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : levels.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _loadLevels,
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
                                selectedTileColor:
                                    Theme.of(context).primaryColor,
                                title: AppText(
                                  levels[index].name ?? '',
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
                      ),
                      AppProgressButton(
                        backgroundColor:
                            selectedIndex == -1 ? Colors.grey : null,
                        onPressed: (animationController) async {
                          if (selectedIndex == -1) {
                            return;
                          } else {
                            Get.to(
                              () => SubjectsScreen(
                                countryModel: widget.countryModel,
                                universityModel: widget.universityModel,
                                collegeModel: widget.collegeModel,
                                levelModel: levels[selectedIndex],
                              ),
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
