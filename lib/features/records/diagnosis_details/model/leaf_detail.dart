import 'dart:io';

import 'package:wheatwise/features/records/diagnosis_details/database/diagnosis_database.dart';

class LeafDetail {
  Diagnosis diagnosis;
  File originalImage;

  LeafDetail({
    required this.diagnosis,
    required this.originalImage,
  });

  factory LeafDetail.fromJson(Map<String, dynamic> json) {
    return LeafDetail(
      diagnosis: json['diagnosis'],
      originalImage: json['originalImage'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    json['Diagnosis'] = Diagnosis;
    json['originalImage'] = originalImage;
    return json;
  }
}
