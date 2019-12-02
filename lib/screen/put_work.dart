import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'baseState.dart';
import 'baseWidget.dart';

class PutWork extends BaseWidget{
  _PutWork createState() => _PutWork();
}

class _PutWork extends BaseState<PutWork>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Text('PutWork'),
    );
  }
}