import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/presentation/screens/country/country_screen.dart';
import 'package:get/route_manager.dart';

import '../my_controllers/general_controller.dart';

class HomeScreenController extends GeneralController {
  List subjects = [];

  String countryImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fe/Flag_of_Egypt.svg/1024px-Flag_of_Egypt.svg.png';
  String countryName = 'Egypt';
  String universityName = 'Mansoura';
  String collegeName = 'Computer Science';
  String levelName = 'Level 4';

  bool firstLogin = true;

  @override
  void onInit() async {
    super.onInit();

    init();
  }

  void init() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (firstLogin) {
        Get.to(() => const CountryScreen());
      } else {
        getSubjects();
      }
    });
  }

  Future<void> getSubjects() async {
    operationReply = OperationReply.loading();
    await Future.delayed(const Duration(seconds: 4));
    subjects = [
      {
        'name': 'مادة الهستولوجيا',
        'lessons': [
          {'name': 'هستولوجي (علم الانسجة) المحاضرة الأولي'},
          {'name': 'هستولوجي (علم الانسجة) المحاضرة الثانية'},
          {'name': 'هستولوجي (علم الانسجة) المحاضرة الثالثة'}
        ]
      },
      {
        'name': 'الفارماكولوجيا الاكلينيكية',
        'lessons': [
          {'name': 'الفارماكولوجيا الاكلينيكية 1'},
          {'name': 'الفارماكولوجيا الاكلينيكية 2'},
          {'name': 'الفارماكولوجيا الاكلينيكية 3'}
        ]
      },
      {
        'name': 'الفارماكولوجيا الاكلينيكية',
        'lessons': [
          {'name': 'الفارماكولوجيا الاكلينيكية 1'},
          {'name': 'الفارماكولوجيا الاكلينيكية 2'},
          {'name': 'الفارماكولوجيا الاكلينيكية 3'}
        ]
      },
      {
        'name': 'الفارماكولوجيا الاكلينيكية',
        'lessons': [
          {'name': 'الفارماكولوجيا الاكلينيكية 1'},
          {'name': 'الفارماكولوجيا الاكلينيكية 2'},
          {'name': 'الفارماكولوجيا الاكلينيكية 3'}
        ]
      },
    ];

    operationReply = OperationReply.success();
  }

  @override
  Future<void> refreshApiCall() async {
    await getSubjects();
  }
}
