import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/student_model.dart';
import 'package:student_management/provider/student_provider.dart';
import 'package:student_management/provider/teacher_provider.dart';

class StudentDetailsPage extends StatefulWidget {
  static const String routeName='/student_details';

  @override
  State<StudentDetailsPage> createState() => _StudentDetailsPageState();
}

class _StudentDetailsPageState extends State<StudentDetailsPage> {
  @override
  Widget build(BuildContext context) {
    var id;
    return Scaffold(
      appBar: AppBar(title: Text('Student Details'),),
      body: Center(
        child: Consumer<TeacherProvider>(
          builder:(context,provider,_)=> FutureBuilder<StudentModel>(
            future: provider.getStudentById(id!),
            builder: (context,snapshot){
              if(snapshot.hasData){
                final student=snapshot.data;
                return ListView(
                  children: [
                    Image.file(File(student!.image!),width:double.infinity,height:300,fit:BoxFit.cover,),
                    ListTile(
                      title: Text(student.name),
                      subtitle: Text(student.roll),
                    ),
                  ],
                );
              }
              if(snapshot.hasError){
                return const Text('Failed to Fetch Data');
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
