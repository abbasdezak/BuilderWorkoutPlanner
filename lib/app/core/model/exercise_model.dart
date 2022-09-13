import 'package:flutter/cupertino.dart';

class AllPlans {
  List<Plan>? plans;

  AllPlans({this.plans});

  AllPlans.fromJson(Map<String, dynamic> json) {
    if (json['Plans'] != null) {
      plans = <Plan>[];
      json['Plans'].forEach((v) {
        plans!.add(new Plan.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.plans != null) {
      data['Plans'] = this.plans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Plan {
  String? planName;
  List<Company>? exercises;

  Plan({this.exercises, this.planName});

  Plan.fromJson(Map<String, dynamic> json) {
    planName = json["PLANNAME"];
    if (json['Exercises'] != null) {
      exercises = <Company>[];
      json['Exercises'].forEach((v) {
        exercises!.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PLANNAME'] = this.planName;
    if (this.exercises != null) {
      data['Exercises'] = this.exercises!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
  Company(
      {this.sets,
      this.usage,
      this.howTo,
      this.id,
      this.name,
      this.imgurl,
      this.ischeck = false,
      this.isSelected = false});
  List<SetDetails>? sets;
  int? id;
  String? name;
  String? imgurl;
  String? usage;
  String? howTo;
  bool? ischeck;
  bool? isSelected;

  Company.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    name = json["NAME"];
    usage = json["USAGE"];
    howTo = json["HOWTO"];
    imgurl = json["IMGURL"];
    if (json["SETS"] != null) {
      sets = <SetDetails>[];
      json["SETS"].forEach((x) => sets!.add(SetDetails.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() => {
        "ID": this.id,
        "NAME": this.name,
        "IMGURL": this.imgurl,
        "USAGE": this.usage,
        "HOWTO": this.howTo,
        "SETS": this.sets!.map((e) => e.toJson()).toList()
      };

  @override
  String toString() {
    return 'Company{id : $id, name: $name, img_url = $imgurl}';
  }
}

class SetDetails {
  int? setNumber;
  String? weight;
  String? reps;
  TextEditingController? weightController;
  TextEditingController? repsController;

  Map<String, dynamic> toJson() => {
        "SET": this.setNumber,
        "REPS": this.repsController != null
            ? this.repsController!.text
            : this.reps,
        "WEIGHT": this.weightController != null
            ? this.weightController!.text
            : this.weight,
      };
  factory SetDetails.fromJson(Map<String, dynamic> json) => SetDetails(
      setNumber: json["SET"], reps: json["REPS"], weight: json["WEIGHT"]);

  SetDetails({
    this.setNumber,
    this.weight,
    this.reps,
    this.weightController,
    this.repsController,
  });
}
