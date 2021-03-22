import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/employees.dart';
import 'package:sample/widget/slidable.dart';

class PaidList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeesProvider>(context);
    final employees = provider.employeesCompleted;

    return employees.isEmpty
        ? Center(
            child: Text(
              'No completed tasks.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : ListView.separated(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(16),
            separatorBuilder: (context, index) => Container(height: 8),
            itemCount: employees.length,
            itemBuilder: (context, index) {
              final employee = employees[index];

              return SlideWidget(employee: employee);
            },
          );
  }
}
