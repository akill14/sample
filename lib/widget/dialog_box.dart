import 'package:flutter/material.dart';
import 'package:sample/widget/form.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/employees.dart';
import 'package:sample/model/employee.dart';

class DialogWidget extends StatefulWidget {
  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  String department = '';
  String salary = '';

  @override
  Widget build(BuildContext context) => AlertDialog(
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Employee',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),
              FormWidget(
                onChangedName: (name) => setState(() => this.name = name),
                onChangedDepartment: (department) =>
                    setState(() => this.department = department),
                onChangedSalary: (salary) =>
                    setState(() => this.salary = salary),
                onSavedEmployee: addEmployee,
              ),
            ],
          ),
        ),
      );

  void addEmployee() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final employee = Employee(
        id: DateTime.now().toString(),
        name: name,
        department: department,
        salary: salary,
        createdTime: DateTime.now(),
      );

      final provider = Provider.of<EmployeesProvider>(context, listen: false);
      provider.addEmployee(employee);

      Navigator.of(context).pop();
    }
  }
}
