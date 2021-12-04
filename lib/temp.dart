import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

void main() {
  print(json.decode("""{"1":"1","1":"2"}""", reviver: (k, v) {
    return MapEntry(int.parse(k.toString()), int.parse(v.toString()));
  }) as Map<int, int>);
  //     .replaceAll("{", "")
  //     .replaceAll("}", "")
  //     .split(",")
  //     .map((e) {
  //   var s = e.split(":");
  //   return MapEntry(s.first, s.last);
  // }));
}
