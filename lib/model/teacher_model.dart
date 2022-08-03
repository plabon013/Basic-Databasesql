import 'package:flutter/material.dart';

const String tableTeacher = 'tbl_teacher';
const String tableTeacherColId = 'id';
const String tableTeacherColName = 'name';
const String tableTeacherColNumber = 'number';
const String tableTeacherColEmail = 'Email';
const String tableTeacherColPost = 'post';
const String tableTeacherColAddress = 'address';
const String tableTeacherColDob = 'dob';
const String tableTeacherColGender = 'gender';
const String tableTeacherColImage = 'image';

class TeacherModel {
  int? id;
  String name;
  String number;
  String email;
  String post;
  String address;
  String?dob;
  String? gender;
  String?image;

  TeacherModel(
      {required this.name,
      required this.number,
      required this.email,
      required this.post,
      required this.address,
       this.dob,
       this.gender,
       this.image,
      this.id});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      tableTeacherColName: name,
      tableTeacherColNumber: number,
      tableTeacherColEmail: email,
      tableTeacherColPost: post,
      tableTeacherColAddress: address,
      tableTeacherColDob: dob,
      tableTeacherColGender: gender,
      tableTeacherColImage: image
    };
    if (id != null) {
      map[tableTeacherColId] = id;
    }
    return map;
  }

  factory TeacherModel.fromMap(Map<String, dynamic> map) => TeacherModel(
        id: map[tableTeacherColId],
        name: map[tableTeacherColName],
        number: map[tableTeacherColNumber],
        email: map[tableTeacherColEmail],
        post: map[tableTeacherColPost],
        address: map[tableTeacherColAddress],
        dob: map[tableTeacherColDob],
        gender: map[tableTeacherColGender],
        image: map[tableTeacherColImage],
      );

  @override
  String toString() {
    return 'TeacherModel{id: $id, name: $name, number: $number, email: $email, post: $post, address: $address, dob: $dob, gender: $gender, image: $image}';
  }
}
