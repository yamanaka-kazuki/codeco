import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class QrModel {
  @Id()
  int id = 0;

  String? title;
  Image? image;
  @Property(type: PropertyType.date)
  DateTime? deadline;
  bool? isUsed;

  QrModel({this.title, this.image, this.deadline, this.isUsed});
}
