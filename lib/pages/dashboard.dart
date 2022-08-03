import 'package:flutter/material.dart';
import 'package:student_management/auth_prefs.dart';
import 'package:student_management/pages/add_student_page.dart';
import 'package:student_management/pages/login_page.dart';
import 'package:student_management/pages/student_list_page.dart';
import 'package:student_management/pages/teacher_list_page.dart';

class Dashboard extends StatefulWidget {
  static const String routeName = '/dashboard';

  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                        onTap: () {
                          setLoginStatus(false).then((value) =>
                              Navigator.pushReplacementNamed(
                                  context, LoginPage.routeName));
                        },
                        child: const Text('Logout'))
                  ]),
        ],
        title: Text('DashBoard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(30.0),
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  'Teacher List',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, TeacherListPage.routeName);
                },
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            Container(
              margin: EdgeInsets.all(30.0),
              width: double.infinity,
              child: FlatButton(
                child: Text(
                  'Student List',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, StudentListPage.routeName);
                },
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
