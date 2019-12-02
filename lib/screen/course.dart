import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Course extends StatefulWidget{
  _Course createState() => _Course();
}

class _Course extends State<Course>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('Course'),
    );
  }
}