import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/model/employee.dart';
import 'package:sample/provider/employees.dart';
import 'package:sample/widget/form.dart';

class EditEmployeePage extends StatefulWidget {
  final Employee employee;

  const EditEmployeePage({Key key, @required this.employee}) : super(key: key);

  @override
  _EditEmployeePageState createState() => _EditEmployeePageState();
}

class _EditEmployeePageState extends State<EditEmployeePage> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String department;
  String salary;

  @override
  void initState() {
    super.initState();

    name = widget.employee.name;
    department = widget.employee.department;
    salary = widget.employee.salary;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text('Edit Employee'),
          actions: [
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final provider =
                    Provider.of<EmployeesProvider>(context, listen: false);
                provider.removeEmployee(widget.employee);

                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: FormWidget(
              name: name,
              department: department,
              onChangedName: (name) => setState(() => this.name = name),
              onChangedDepartment: (department) =>
                  setState(() => this.department = department),
              onChangedSalary: (salary) => setState(() => this.salary = salary),
              onSavedEmployee: saveEmployee,
            ),
          ),
        ),
      );

  void saveEmployee() {
    final isValid = _formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final provider = Provider.of<EmployeesProvider>(context, listen: false);

      provider.updateEmployee(widget.employee, name, department, salary);

      Navigator.of(context).pop();
    }
  }
}
