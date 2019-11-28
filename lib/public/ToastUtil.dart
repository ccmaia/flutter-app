

import 'package:oktoast/oktoast.dart';

/// Toast工具类
class Toast {
  static show(String msg, {duration = 2000}) {
    if (msg == null){
      return;
    }
    showToast(
        msg,
        duration: Duration(milliseconds: duration),
        dismissOtherToast: true
    );
  }

  static cancelToast() {
    dismissAllToast();
  }
}


//String readTimestamp(int timestamp) {
//  var now = new DateTime.now();
//  var format = new DateFormat('HH:mm a');
//  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
//  var diff = now.difference(date);
//  var time = '';
//
//  if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
//    time = format.format(date);
//  } else if (diff.inDays > 0 && diff.inDays < 7) {
//    if (diff.inDays == 1) {
//      time = diff.inDays.toString() + ' DAY AGO';
//    } else {
//      time = diff.inDays.toString() + ' DAYS AGO';
//    }
//  } else {
//    if (diff.inDays == 7) {
//      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
//    } else {
//
//      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
//    }
//  }
//
//  return time;
//}