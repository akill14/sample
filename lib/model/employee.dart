import 'package:flutter/cupertino.dart';
import 'package:sample/utils.dart';

class EmployeeField {
  static const createdTime = 'createdTime';
}

class Employee {
  DateTime createdTime;
  String name;
  String department;
  String id;
  String salary;
  bool isDone;

  Employee({
    @required this.createdTime,
    @required this.name,
    @required this.department,
    @required this.salary,
    this.id,
    this.isDone = false,
  });

  static Employee fromJson(Map<String, dynamic> json) => Employee(
        createdTime: Utils.toDateTime(json['createdTime']),
        name: json['name'],
        department: json['department'],
        id: json['id'],
        salary: json['salary'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(createdTime),
        'name': name,
        'department': department,
        'id': id,
        'salary': salary,
        'isDone': isDone,
      };
}
