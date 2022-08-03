import 'package:flutter/cupertino.dart';
import 'package:student_management/db/db_helper.dart';
import 'package:student_management/model/student_model.dart';

import '../model/teacher_model.dart';

class TeacherProvider extends ChangeNotifier {
  List<TeacherModel> teacherList = [];
  List<StudentModel> studentList = [];

  getAllTeachers() {
    DBHelper.getAllTeachers().then((value) {
      teacherList = value;
      notifyListeners();
    });
  }

  Future<TeacherModel> getTeacherById(int id) => DBHelper.getTeacherById(id);

  Future<bool> addNewTeacher(TeacherModel teacherModel) async {
    final rowId = await DBHelper.insertTeacher(teacherModel);
    if (rowId > 0) {
      teacherModel.id = rowId;
      teacherList.add(teacherModel);
      notifyListeners();
      return true;
    }
    return false;
  }

  deleteTeacher(int id) async {
    final rowId = await DBHelper.deleteTeacher(id);
    if (rowId > 0) {
      teacherList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  getAllStudents() {
    DBHelper.getAllStudents().then((value) {
      studentList = value;
      notifyListeners();
    });
  }
  Future<StudentModel> getStudentById(int id)=>DBHelper.getStudentById(id);

  Future<bool>addNewStudent(StudentModel studentModel) async{
    final rowId = await DBHelper.insertStudent(studentModel);
    if(rowId>0){
      studentModel.id=rowId;
      studentList.add(studentModel);
      notifyListeners();
      return true;
    }
    return false;
  }
  deleteStudent(int id) async{
    final rowId = await DBHelper.deleteStudent(id);
    if(rowId>0){
      studentList.removeWhere((element) => element.id==id);
      notifyListeners();
    }
  }
}