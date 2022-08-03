import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/model/teacher_model.dart';
import 'package:student_management/provider/teacher_provider.dart';

class TeacherDetailsPage extends StatefulWidget {
  static const String routeName='/teacher_details';

  @override
  State<TeacherDetailsPage> createState() => _TeacherDetailsPageState();
}

class _TeacherDetailsPageState extends State<TeacherDetailsPage> {
  int? id;
  @override
  void didChangeDependencies() {
    id=ModalRoute.of(context)!.settings.arguments as int;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Teacher Details'),),
      body: Center(
        child: Consumer<TeacherProvider>(
          builder:(context,provider,_)=> FutureBuilder<TeacherModel>(
            future: provider.getTeacherById(id!),
            builder: (context,snapshot){
              if(snapshot.hasData){
                final teacher=snapshot.data;
                return ListView(
                  children: [
                    Image.file(File(teacher!.image!),width:double.infinity,height:300,fit:BoxFit.cover,),
                    ListTile(
                      title: Text(teacher.name),
                      subtitle: Text(teacher.post),
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
