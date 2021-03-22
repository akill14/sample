import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final String name;
  final String department;
  final String salary;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedDepartment;
  final ValueChanged<String> onChangedSalary;
  final VoidCallback onSavedEmployee;

  const FormWidget({
    Key key,
    this.name = '',
    this.department = '',
    this.salary = 'RM ',
    @required this.onChangedName,
    @required this.onChangedDepartment,
    @required this.onChangedSalary,
    @required this.onSavedEmployee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildName(),
            SizedBox(height: 8),
            buildDepartment(),
            SizedBox(height: 8),
            buildSalary(),
            SizedBox(height: 8),
            buildButton(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        maxLines: 1,
        initialValue: name,
        onChanged: onChangedName,
        validator: (name) {
          if (name.isEmpty) {
            return 'Please enter employee name';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Name',
        ),
      );

  Widget buildDepartment() => TextFormField(
        maxLines: 1,
        initialValue: department,
        onChanged: onChangedDepartment,
        validator: (department) {
          if (department.isEmpty) {
            return 'Please enter the department';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Department',
        ),
      );

  Widget buildSalary() => TextFormField(
        maxLines: 1,
        onChanged: onChangedSalary,
        validator: (salary) {
          if (salary.isEmpty) {
            return 'Please enter the salary';
          }
          return null;
        },
        decoration: InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Salary',
        ),
      );

  Widget buildButton() => SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          onPressed: onSavedEmployee,
          child: Text('Save'),
        ),
      );
}
