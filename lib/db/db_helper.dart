import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management/model/student_model.dart';
import 'package:student_management/model/teacher_model.dart';

class DBHelper {
  static const String createTableTeacher = ''' create table $tableTeacher(
  $tableTeacherColId integer primary key,
  $tableTeacherColName text,
  $tableTeacherColNumber text,
  $tableTeacherColEmail text,
  $tableTeacherColPost text,
  $tableTeacherColAddress text,
  $tableTeacherColDob text,
  $tableTeacherColGender text,
  $tableTeacherColImage text
  
  )''';
  static const String createTableStudent =
      ''' create table $tableStudent( $tableStudentColId integer primary key,
      $tableStudentColName text,
      $tableStudentColRoll text,
      $tableStudentColAddress text,
      $tableStudentColDob text,
      $tableStudentColGender text,
      $tableStudentColImage text
  )''';

  static Future<Database> open() async {
    final rootPath = await getDatabasesPath();
    final dbpath = join(rootPath, 'teacher.db');

    return openDatabase(dbpath, version: 1, onCreate: (db, version) {
      db.execute(createTableTeacher);
      db.execute(createTableStudent);
    });
  }

  static Future<int> insertTeacher(TeacherModel teacherModel) async {
    final db = await open();
    return db.insert(tableTeacher, teacherModel.toMap());
  }

  static Future<int> insertStudent(StudentModel studentModel) async {
    final db = await open();
    return db.insert(tableStudent, studentModel.toMap());
  }

  static Future<List<TeacherModel>> getAllTeachers() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tableTeacher);
    return List.generate(
        mapList.length, (index) => TeacherModel.fromMap(mapList[index]));
  }

  static Future<List<StudentModel>> getAllStudents() async {
    final db = await open();
    final List<Map<String, dynamic>> mapList = await db.query(tableStudent);
    return List.generate(
        mapList.length, (index) => StudentModel.fromMap(mapList[index]));
  }

  static Future<TeacherModel> getTeacherById(int id) async {
    final db = await open();
    final mapList = await db
        .query(tableTeacher, where: '$tableTeacherColId = ?', whereArgs: [id]);
    return TeacherModel.fromMap(mapList.first);
  }

  static Future<StudentModel> getStudentById(int id) async {
    final db1 = await open();
    final mapList = await db1
        .query(tableStudent, where: '$tableStudentColId = ?', whereArgs: [id]);
    return StudentModel.fromMap(mapList.first);
  }

  static Future<int> deleteTeacher(int id) async {
    final db = await open();
    return db
        .delete(tableTeacher, where: '$tableTeacherColId=?', whereArgs: [id]);
  }
  static Future<int> deleteStudent(int id) async {
    final db = await open();
    return db
        .delete(tableStudent, where: '$tableStudentColId=?', whereArgs: [id]);
  }
}
