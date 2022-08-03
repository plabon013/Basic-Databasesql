import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:student_management/auth_prefs.dart';
import 'package:student_management/pages/dashboard.dart';
import 'package:student_management/pages/login_page.dart';
import 'package:student_management/pages/teacher_list_page.dart';

class LauncherPage extends StatefulWidget {
  static const String routeName='/launcher';
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  @override
  void initState() {
   getLoginStatus().then((value){
     if(value){
       Navigator.pushReplacementNamed(context, Dashboard.routeName);
     }
     else{
       Navigator.pushReplacementNamed(context, LoginPage.routeName);
     }
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
