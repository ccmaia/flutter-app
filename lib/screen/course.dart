import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'baseState.dart';
import 'baseWidget.dart';

class Course extends BaseWidget{
  _Course createState() => _Course();
}

class _Course extends BaseState<Course>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('Course'),
    );
  }
}