import 'package:flutter/cupertino.dart';
import 'package:sample/api/firebase.dart';
import 'package:sample/model/employee.dart';

class EmployeesProvider extends ChangeNotifier {
  List<Employee> _employees = [];

  List<Employee> get employees =>
      _employees.where((employee) => employee.isDone == false).toList();

  List<Employee> get employeesCompleted =>
      _employees.where((employee) => employee.isDone == true).toList();

  void setEmployees(List<Employee> employees) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _employees = employees;
        notifyListeners();
      });

  void addEmployee(Employee employee) => FirebaseApi.addEmployee(employee);

  void removeEmployee(Employee employee) =>
      FirebaseApi.deleteEmployee(employee);

  bool toggleEmployeeStatus(Employee employee) {
    employee.isDone = !employee.isDone;
    FirebaseApi.updateEmployee(employee);

    return employee.isDone;
  }

  void updateEmployee(
      Employee employee, String name, String department, String salary) {
    employee.name = name;
    employee.department = department;
    employee.salary = salary;

    FirebaseApi.updateEmployee(employee);
  }
}
