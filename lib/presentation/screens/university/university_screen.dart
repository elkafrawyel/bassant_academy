import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/entities/country_model.dart';
import 'package:bassant_academy/data/entities/university_model.dart';
import 'package:bassant_academy/data/entities/university_response.dart';
import 'package:bassant_academy/presentation/screens/college/college_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../app/util/operation_reply.dart';
import '../../../data/providers/network/api_provider.dart';
import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text.dart';

class UniversityScreen extends StatefulWidget {
  final CountryModel countryModel;

  const UniversityScreen({
    super.key,
    required this.countryModel,
  });

  @override
  State<UniversityScreen> createState() => _UniversityScreenState();
}

class _UniversityScreenState extends State<UniversityScreen> {
  int selectedIndex = -1;

  List<UniversityModel> universities = [];
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
    _loadUniversities();
  }

  Future<void> _loadUniversities() async {
    loading = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: '${Res.apiUniversities}?countryId=${widget.countryModel.id}',
      fromJson: UniversityResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      UniversityResponse universityResponse = operationReply.result;
      universities = universityResponse.data ?? [];
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
        title:
            Text('${'choose_university'.tr} ( ${widget.countryModel.name} )'),
        centerTitle: false,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : universities.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _loadUniversities,
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
                                title: Row(
                                  children: [
                                    AppCachedImage(
                                      imageUrl: universities[index].image,
                                      width: 40,
                                      height: 40,
                                    ),
                                    10.pw,
                                    AppText(universities[index].name ?? ''),
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
                      ),
                      AppProgressButton(
                        backgroundColor:
                            selectedIndex == -1 ? Colors.grey : null,
                        onPressed: (animationController) async {
                          if (selectedIndex == -1) {
                            return;
                          } else {
                            Get.to(
                              () => CollegeScreen(
                                countryModel: widget.countryModel,
                                universityModel: universities[selectedIndex],
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
