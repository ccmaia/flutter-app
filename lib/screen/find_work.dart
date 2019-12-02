import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'baseState.dart';
import 'baseWidget.dart';

class FindWork extends BaseWidget{
  _FindWork createState() => _FindWork();
}

class _FindWork extends BaseState<FindWork>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('FindWork'),
    );
  }
}