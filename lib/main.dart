import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:student_management/pages/add_student_page.dart';
import 'package:student_management/pages/add_teacher_page.dart';
import 'package:student_management/pages/dashboard.dart';
import 'package:student_management/pages/launcher_page.dart';
import 'package:student_management/pages/login_page.dart';
import 'package:student_management/pages/student_details_page.dart';
import 'package:student_management/pages/student_list_page.dart';
import 'package:student_management/pages/teacher_details_page.dart';
import 'package:student_management/pages/teacher_list_page.dart';
import 'package:student_management/provider/student_provider.dart';
import 'package:student_management/provider/teacher_provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>TeacherProvider()..getAllTeachers()),
        ChangeNotifierProvider(create: (context)=>TeacherProvider()..getAllStudents()),
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

      initialRoute: LauncherPage.routeName,

      routes: {
        LauncherPage.routeName:(context)=>LauncherPage(),
        Dashboard.routeName:(context)=>Dashboard(),
        LoginPage.routeName:(context)=>LoginPage(),
        AddTeacherPage.routeName:(context)=>AddTeacherPage(),
        TeacherListPage.routeName:(context)=>TeacherListPage(),
        TeacherDetailsPage.routeName:(context)=>TeacherDetailsPage(),
        StudentListPage.routeName:(context)=>StudentListPage(),
        AddStudentPage.routeName:(context)=>AddStudentPage(),
        StudentDetailsPage.routeName:(context)=>StudentDetailsPage(),
      },
    );
  }
}


