import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/pages/add_teacher_page.dart';
import 'package:student_management/pages/teacher_details_page.dart';
import 'package:student_management/provider/teacher_provider.dart';

import '../model/teacher_model.dart';

class TeacherListPage extends StatefulWidget {
  static const String routeName = '/teacher_list';

  @override
  State<TeacherListPage> createState() => _TeacherListPageState();
}

class _TeacherListPageState extends State<TeacherListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher List'),
      ),
      body: Consumer<TeacherProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.teacherList.length,
            itemBuilder: (context, index) {
              final teacher = provider.teacherList[index];
              return Dismissible(
                key: ValueKey(teacher.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: _showConfirmationDialog,
                onDismissed: (direction){
                  provider.deleteTeacher(teacher.id!);
                },
                background: Container(
                  alignment: Alignment.centerRight,
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                child: ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, TeacherDetailsPage.routeName,
                      arguments: teacher.id),
                  title: Text(teacher.name),
                  subtitle: Text(teacher.post),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddTeacherPage.routeName);
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Teacher',
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Delete Teacher Info'),
              content: const Text('Are You Sure to Delete Teacher Information?'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: const Text('NO')),

                TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: const Text('YES')),
              ],
            ));
  }
}
