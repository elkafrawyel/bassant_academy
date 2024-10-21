import 'package:bassant_academy/app/res/res.dart';
import 'package:bassant_academy/app/util/information_viewer.dart';
import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/data/entities/my_students_response.dart';
import 'package:bassant_academy/data/providers/network/api_provider.dart';
import 'package:bassant_academy/presentation/controller/my_controllers/general_controller.dart';

import '../../../data/entities/student_model.dart';

class StudentsController extends GeneralController {
  List<StudentModel> students = [];

  @override
  void onInit() {
    super.onInit();
    students.clear();
    _loadStudents();
  }

  @override
  Future<void> refreshApiCall() async {
    _loadStudents();
  }

  Future _loadStudents() async {
    operationReply = OperationReply.loading();
    operationReply = await APIProvider.instance.get(
      endPoint: Res.apiMyStudents,
      fromJson: MyStudentsResponse.fromJson,
    );

    if (operationReply.isSuccess()) {
      MyStudentsResponse myStudentsResponse = operationReply.result;
      students = myStudentsResponse.data ?? [];
      if (students.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
      }
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
