import 'package:flutter/material.dart';
import 'package:sample/api/authentication.dart';
import 'package:provider/provider.dart';
import 'package:sample/api/firebase.dart';
import 'package:sample/model/employee.dart';
import 'package:sample/provider/employees.dart';
import 'package:sample/widget/dialog_box.dart';
import 'package:sample/widget/employee_list.dart';
import 'package:sample/widget/paid_list.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      EmployeeListWidget(),
      PaidList(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD & Auth'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage("images/user.jpg"),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                context.read<AuthenticationService>().signOut();
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.monetization_on, size: 28),
            label: 'Paid',
          ),
        ],
      ),
      body: StreamBuilder<List<Employee>>(
        stream: FirebaseApi.readEmployee(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return buildText('Something Went Wrong Try later');
              } else {
                final employees = snapshot.data;

                final provider = Provider.of<EmployeesProvider>(context);
                provider.setEmployees(employees);

                return tabs[selectedIndex];
              }
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          builder: (context) => DialogWidget(),
          barrierDismissible: false,
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );
