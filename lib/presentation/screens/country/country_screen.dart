import 'package:bassant_academy/app/extensions/space.dart';
import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/country_model.dart';
import 'package:bassant_academy/data/entities/country_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/screens/university/university_screen.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:bassant_academy/presentation/widgets/app_widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({super.key});

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  List<CountryModel> countries = [];

  int selectedIndex = -1;

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
    _loadCountries();
  }

  Future<void> _loadCountries() async {
    loading = true;

    OperationReply operationReply = await APIProvider.instance.get(
      endPoint: Res.apiCountries,
      fromJson: CountryResponse.fromJson,
    );
    if (operationReply.isSuccess()) {
      CountryResponse countryResponse = operationReply.result;
      countries = countryResponse.data ?? [];
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
        title: Text('choose_country'.tr),
        centerTitle: false,
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : countries.isEmpty
              ? const SizedBox()
              : Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: _loadCountries,
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
                                      imageUrl: countries[index].image,
                                      width: 40,
                                      height: 40,
                                    ),
                                    10.pw,
                                    AppText(countries[index].name ?? ''),
                                  ],
                                ),
                                selectedColor: Colors.white,
                                tileColor: const Color(0xffF5F5F5),
                              ),
                            ),
                            separatorBuilder: (context, index) => 10.ph,
                            itemCount: countries.length,
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
                              () => UniversityScreen(
                                countryModel: countries[selectedIndex],
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
