import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/general_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String html = '';

  @override
  void initState() {
    super.initState();
    _loadAboutUsData();
  }

  _loadAboutUsData() async {
    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: Res.apiAboutUs,
      fromJson: GeneralResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      html = generalResponse.message ?? '';
      setState(() {});
    } else {
      InformationViewer.showToastBasedOnReply(operationReply);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          'about_academy'.tr,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: AppText(
          html,
          maxLines: 1000,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );
  }
}
