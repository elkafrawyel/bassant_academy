import 'package:bassant_academy/app/util/operation_reply.dart';
import 'package:bassant_academy/presentation/controller/my_controllers/general_controller.dart';

import '../../../data/entities/user_model.dart';

class StudentsController extends GeneralController {
  List<UserModel> students = [];

  @override
  void onInit() {
    super.onInit();
    _loadStudents();
  }

  @override
  Future<void> refreshApiCall() async {
    _loadStudents();
  }

  Future _loadStudents() async {
    operationReply = OperationReply.loading();
    await Future.delayed(const Duration(seconds: 3));
    students = [
      UserModel(
        name: 'Mahmoud',
      ),
      UserModel(
        name: 'Ali',
      ),
      UserModel(
        name: 'Ahmed',
      ),
      UserModel(
        name: 'Khaled',
      ),
    ];
    if (students.isEmpty) {
      operationReply = OperationReply.empty();
    } else {
      operationReply = OperationReply.success();
    }
  }
}
