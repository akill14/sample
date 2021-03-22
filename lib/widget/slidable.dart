import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sample/model/employee.dart';
import 'package:sample/page/edit.dart';
import 'package:sample/provider/employees.dart';
import 'package:sample/utils.dart';

class SlideWidget extends StatelessWidget {
  final Employee employee;

  const SlideWidget({@required this.employee, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Slidable(
          actionPane: SlidableScrollActionPane(),
          key: Key(employee.id),
          actions: [
            IconSlideAction(
              color: Colors.green,
              onTap: () => editEmployee(context, employee),
              caption: 'Edit',
              icon: Icons.edit,
            )
          ],
          secondaryActions: [
            IconSlideAction(
              color: Colors.red,
              onTap: () => deleteEmployee(context, employee),
              caption: 'Delete',
              icon: Icons.delete,
            )
          ],
          child: buildEmployee(context),
        ),
      );

  Widget buildEmployee(BuildContext context) => GestureDetector(
        onTap: () => editEmployee(context, employee),
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                checkColor: Colors.white,
                value: employee.isDone,
                onChanged: (_) {
                  final provider =
                      Provider.of<EmployeesProvider>(context, listen: false);
                  final isDone = provider.toggleEmployeeStatus(employee);

                  Utils.showSnackBar(
                    context,
                    isDone ? 'Paid' : 'Not Paid',
                  );
                },
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      employee.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      employee.department,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      "MYR " + employee.salary,
                      style: TextStyle(
                        fontSize: 20,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  void deleteEmployee(BuildContext context, Employee employee) {
    final provider = Provider.of<EmployeesProvider>(context, listen: false);
    provider.removeEmployee(employee);

    Utils.showSnackBar(context, 'Deleted the employee');
  }

  void editEmployee(BuildContext context, Employee employee) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditEmployeePage(employee: employee),
        ),
      );
}
