import 'package:flutter/material.dart';

const String tableStudent = 'tbl_student';
const String tableStudentColId = 'id';
const String tableStudentColName = 'name';
const String tableStudentColRoll = 'roll';
const String tableStudentColAddress = 'address';
const String tableStudentColDob = 'dob';
const String tableStudentColGender = 'gender';
const String tableStudentColImage = 'image';


class StudentModel {
  int? id;
  String name;
  String roll;
  String address;
  String? dob;
  String? gender;
  String? image;

  StudentModel({required this.name,
    required this.roll,
    required this.address,
    this.dob,
    this.gender,
    this.image,
    this.id});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableStudentColName: name,
      tableStudentColRoll:roll,
      tableStudentColAddress: address,
      tableStudentColDob: dob,
      tableStudentColGender: gender,
      tableStudentColImage: image
    };

    if (id != null) {
      map[tableStudentColId] = id;
    }
    return map;
  }
  factory StudentModel.fromMap(Map<String, dynamic> map) => StudentModel(
    id: map[tableStudentColId],
    name: map[tableStudentColName],
    roll: map[tableStudentColRoll],
    address: map[tableStudentColAddress],
    dob: map[tableStudentColDob],
    gender: map[tableStudentColGender],
    image: map[tableStudentColImage],
  );

  @override
  String toString() {
    return 'StudentModel{id: $id, name: $name, roll: $roll, address: $address, dob: $dob, gender: $gender, image: $image}';
  }
}