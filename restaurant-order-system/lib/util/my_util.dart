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
            ? new DateTime(d[0], d[1] - 1, d[2], checkIfZero(d, 3),
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
    DateTime res = new DateTime(d[0], d[1] - 1, d[2], checkIfZero(d, 3),
        checkIfZero(d, 4), checkIfZero(d, 5));

    return res;
  }

  checkIfZero(array, index) {
    if (array.asMap().containsKey(index)) {
      return array[index];
    } else {
      return 0;
    }
  }
}
