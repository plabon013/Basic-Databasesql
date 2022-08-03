import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management/pages/add_student_page.dart';
import 'package:student_management/pages/student_details_page.dart';
import 'package:student_management/provider/teacher_provider.dart';


class StudentListPage extends StatefulWidget {
  static const String routeName = '/studentlist';

  const StudentListPage({Key? key}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Consumer<TeacherProvider>(
        builder: (context, provider, _) => ListView.builder(
            itemCount: provider.studentList.length,
            itemBuilder: (context, index) {
              final teacher = provider.studentList[index];
              var student;
              return Dismissible(
                key: ValueKey(student.id),
                direction: DismissDirection.endToStart,
                confirmDismiss: _showConfirmationDialog,
                onDismissed: (direction){
                  provider.deleteStudent(student.id!);
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
                      context, StudentDetailsPage.routeName,
                      arguments: student.id),
                  title: Text(student.name),
                  subtitle: Text(student.roll),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AddStudentPage.routeName);
        },
        child: Icon(Icons.add),
        tooltip: 'Add New Student',
      ),
    );
  }
  Future<bool?> _showConfirmationDialog(DismissDirection direction) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Delete Student Info'),
          content: const Text('Are You Sure to Delete Student Information?'),
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
