import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sample/model/employee.dart';
import 'package:sample/utils.dart';

class FirebaseApi {
  static Future<String> addEmployee(Employee employee) async {
    final docEmployee = FirebaseFirestore.instance.collection('employee').doc();

    employee.id = docEmployee.id;
    await docEmployee.set(employee.toJson());

    return docEmployee.id;
  }

  static Stream<List<Employee>> readEmployee() => FirebaseFirestore.instance
      .collection('employee')
      .orderBy(EmployeeField.createdTime, descending: true)
      .snapshots()
      .transform(Utils.transformer(Employee.fromJson));

  static Future updateEmployee(Employee employee) async {
    final docEmployee =
        FirebaseFirestore.instance.collection('employee').doc(employee.id);

    await docEmployee.update(employee.toJson());
  }

  static Future deleteEmployee(Employee employee) async {
    final docEmployee =
        FirebaseFirestore.instance.collection('employee').doc(employee.id);

    await docEmployee.delete();
  }
}
