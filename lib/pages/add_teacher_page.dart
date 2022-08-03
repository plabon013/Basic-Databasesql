import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:student_management/db/db_helper.dart';
import 'package:student_management/model/teacher_model.dart';
import 'package:student_management/provider/teacher_provider.dart';

class AddTeacherPage extends StatefulWidget {
  static const String routeName='/add_teacher';
  @override
  State<AddTeacherPage> createState() => _AddTeacherPageState();
}

class _AddTeacherPageState extends State<AddTeacherPage> {
  final nameControler = TextEditingController();
  final numberControler = TextEditingController();
  final emailControler = TextEditingController();
  final postControler = TextEditingController();
  final addressControler = TextEditingController();
  String? _dob;
  String? _genderGroupValue;
  String? _imagePath;
  ImageSource _imageSource = ImageSource.camera;

  final from_key = GlobalKey<FormState>();

  void dispose() {
    nameControler.dispose();
    numberControler.dispose();
    emailControler.dispose();
    postControler.dispose();
    addressControler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
        actions: [
          IconButton(onPressed: _saveTeacher, icon: Icon(Icons.save))
        ],
      ),
      body: Form(
        key: from_key,
        child: ListView(
          children: [
            TextFormField(
              controller: nameControler,
              decoration: InputDecoration(
                labelText: 'Name',
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This Field must not be empty';
                }
                if (value.length > 30) {
                  return 'Name must be in 30 charachters';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: numberControler,
              decoration: InputDecoration(
                labelText: 'Number',
                prefixIcon: Icon(Icons.call),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This Field must not be empty';
                }
                if (value.length > 11) {
                  return 'Number must be in 11 charachters';
                } else {
                  return null;
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: emailControler,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {}),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: postControler,
                decoration: InputDecoration(
                  labelText: 'Post',
                  prefixIcon: Icon(Icons.post_add),
                ),
                validator: (value) {}),
            SizedBox(
              height: 10,
            ),
            TextFormField(
                controller: addressControler,
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_city),
                ),
                validator: (value) {}),
            SizedBox(
              height: 10,
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: _selectDate,
                      child: Text('Select Date of Birth')),
                  Text(_dob == null ? 'No Date Choosen' : _dob!),
                ],
              ),
            ),
            Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Select Gender'),
                  Radio<String>(
                    value: 'Male',
                    groupValue: _genderGroupValue,
                    onChanged: (value) {
                      setState(() {
                        _genderGroupValue = value;
                      });
                    },
                  ),
                  Text('Male'),
                  Radio<String>(
                    value: 'Female',
                    groupValue: _genderGroupValue,
                    onChanged: (value) {
                      setState(() {
                        _genderGroupValue = value;
                      });
                    },
                  ),
                  Text('Female'),
                ],
              ),
            ),
            Card(
              elevation: 5,
              child: _imagePath == null
                  ? Image.asset(
                      'images/pc.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    )
                  : Image.file(
                      File(_imagePath!),
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _imageSource = ImageSource.camera;
                      _getImage();
                    },
                    child: Text('Camera')),
                SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      _imageSource = ImageSource.gallery;
                      _getImage();
                    },
                    child: Text('Gallery')),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _saveTeacher() async {
    if (from_key.currentState!.validate()) {
      final teacher = TeacherModel(
        name: nameControler.text,
        number: numberControler.text,
        email: emailControler.text,
        post: postControler.text,
        address: addressControler.text,
        dob: _dob,
        gender: _genderGroupValue,
        image: _imagePath
      );
      print(teacher.toString());
      final status=await Provider
          .of<TeacherProvider>(context,listen: false)
          .addNewTeacher(teacher);

      if (status) {
        Navigator.pop(context);
      }
    }
  }

  void _selectDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime.now());
    if (selectedDate != null) {
      setState(() {
        _dob = DateFormat('dd/MM/yyyy').format(selectedDate);
      });
    }
  }

  void _getImage() async {
    final selectImage = await ImagePicker().pickImage(source: _imageSource);
    if(selectImage!=null){
      setState((){
        _imagePath=selectImage.path;
      });
    }
  }
}
