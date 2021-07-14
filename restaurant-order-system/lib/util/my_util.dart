import 'package:flutter/material.dart';

class MyUtil {
  static void showSnackBar(BuildContext context, String message) =>
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(message)),
        );

  convertToDateTime(d) {
    return (d is DateTime
        ? d
        : d is List
            ? new DateTime(d[0], d[1], d[2], checkIfZero(d, 3),
                checkIfZero(d, 4), checkIfZero(d, 5))
            : d is num
                ? new DateTime.fromMicrosecondsSinceEpoch(d)
                : d is String
                    ? DateTime.parse(d)
                    : d.runtimeType == Object
                        ? new DateTime(
                            d.year, d.month, d.date, d.hour, d.minute, d.second)
                        : null);
  }

  DateTime convertArrayToDateTime(d) {
    DateTime res = new DateTime(d[0], d[1], d[2], checkIfZero(d, 3),
        checkIfZero(d, 4), checkIfZero(d, 5));

    return res;
  }

  List<String> convertDateTimeToArray(d) {
    List<String> res = [];
    res.add((d as DateTime).year.toString());
    res.add((d as DateTime).month.toString());
    res.add((d as DateTime).day.toString());
    res.add((d as DateTime).hour.toString());
    res.add((d as DateTime).minute.toString());
    res.add((d as DateTime).second.toString());

    return res;
  }

  List<String> convertDateToArray(d) {
    List<String> res = [];
    res.add((d as DateTime).year.toString());
    res.add((d as DateTime).month.toString());
    res.add((d as DateTime).day.toString());

    return res;
  }

  checkIfZero(array, index) {
    if (array.asMap().containsKey(index)) {
      return array[index];
    } else {
      return 0;
    }
  }

  bool isValidDate(String input) {
    var date;
    try {
      date = DateTime.parse(input);
    } catch (e) {
      return false;
    }

    final originalFormatString = toOriginalFormatString(date);
    return input == originalFormatString;
  }

  String toOriginalFormatString(DateTime dateTime) {
    final y = dateTime.year.toString().padLeft(4, '0');
    final m = dateTime.month.toString().padLeft(2, '0');
    final d = dateTime.day.toString().padLeft(2, '0');
    return "$y-$m-$d";
  }
}
