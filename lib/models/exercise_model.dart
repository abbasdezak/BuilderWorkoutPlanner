// To parse this JSON data, do
//
//     final exerciseModel = exerciseModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

// ExerciseModel exerciseModelFromJson(String str) =>
//     ExerciseModel.fromJson(json.decode(str));

String exerciseModelToJson(ExerciseModel data) => json.encode(data.toJson());

class ExerciseModel {
  ExerciseModel({
    required this.company,
  });

  List<Company> company;

  // factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
  //       company:
  //           List<Company>.from(json["COMPANY"].map((x) => Company.fromJson(x))),
  //     );

  Map<String, dynamic> toJson() => {
        "COMPANY": List<dynamic>.from(company.map((x) => x.toMap())),
      };
}

class Company {
  Company( {
    this.img,
    this.exrcs,
    this.sort,
     this.id,
    required this.name,
    this.imgurl,
    this.ischeck,
  });

  List<Company>? exrcs;
  int? id;
  String name;
  String? imgurl;
  Widget? img;
  int? ischeck;
  int? sort;

  // factory Company.fromJson(Map<String, dynamic> json) => Company(
  //       id: json["ID"],
  //       name: json["NAME"],
  //       usage: json["USAGE"],
  //       howto: json["HOWTO"],
  //       imgurl: json["IMGURL"],
  //       ischeck: json["ISCHECK"],
  //     );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "NAME": name,
        "IMGURL": imgurl,
        "ISCHECK": ischeck,
      };

  @override
  String toString() {
    return 'Company{id : $id, name: $name, img_url = $imgurl,sort = $sort}';
  }
}

class AddNewCompany {
  AddNewCompany({
    required this.id,
    required this.name,
    required this.imgurl,
  });

  int id;
  String name;
  String imgurl;

  factory AddNewCompany.fromJson(Map<String, dynamic> json) => AddNewCompany(
        id: json["ID"],
        name: json["NAME"],
        imgurl: json["IMGURL"],
      );

  Map<String, dynamic> toMap() => {
        "ID": id,
        "NAME": name,
        "IMGURL": imgurl,
      };

  @override
  String toString() {
    return 'Company{id : $id, name: $name, img_url = $imgurl}';
  }
}

class NamesOfPlans {
  NamesOfPlans({
    required this.id,
    required this.name,
    this.isUsed,
  });

  int id;
  String name;
  final isUsed;

  Map<String, dynamic> toMap() => {"ID": id, "NAME": name, "ISUSED": isUsed};

  @override
  String toString() {
    return 'Company{id : $id, name: $name,isused:$isUsed}';
  }
}
