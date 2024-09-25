import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/data/entities/college_model.dart';
import 'package:bassant_academy/data/entities/college_response.dart';
import 'package:bassant_academy/data/entities/university_model.dart';
import 'package:bassant_academy/presentation/screens/level/level_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../../app/util/operation_reply.dart';
import '../../../data/providers/network/api_provider.dart';
import '../../widgets/app_widgets/app_text.dart';

class CollegeScreen extends StatefulWidget {
  final UniversityModel universityModel;

  const CollegeScreen({
    super.key,
    required this.universityModel,
  });

  @override
  State<CollegeScreen> createState() => _CollegeScreenState();
}

class _CollegeScreenState extends State<CollegeScreen> {
  List<CollegeModel> colleges = [];

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
    _loadColleges();
  }

  Future<void> _loadColleges() async {
    loading = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint:
          '${Res.apiColleages}?UnivertsityId=${widget.universityModel.id}',
      fromJson: CollegeResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      CollegeResponse collegeResponse = operationReply.result;
      colleges = collegeResponse.data ?? [];
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
            Text('${'choose_college'.tr} ( ${widget.universityModel.name} )'),
        centerTitle: false,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : colleges.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: RefreshIndicator(
                    onRefresh: _loadColleges,
                    child: ListView.separated(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Get.to(
                            () => LevelScreen(
                              collegeModel: colleges[index],
                            ),
                          );
                        },
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                          selectedTileColor: Theme.of(context).primaryColor,
                          title: AppText(
                            colleges[index].name ?? '',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          selectedColor: Colors.white,
                          tileColor: const Color(0xffF5F5F5),
                        ),
                      ),
                      separatorBuilder: (context, index) => 10.ph,
                      itemCount: colleges.length,
                    ),
                  ),
                ),
    );
  }
}
